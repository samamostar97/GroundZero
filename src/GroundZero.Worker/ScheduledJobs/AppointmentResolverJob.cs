using GroundZero.Domain.Enums;
using GroundZero.Infrastructure.Data;
using GroundZero.Messaging;
using GroundZero.Messaging.Events;
using Microsoft.EntityFrameworkCore;

namespace GroundZero.Worker.ScheduledJobs;

public class AppointmentResolverJob : BackgroundService
{
    private readonly IServiceProvider _serviceProvider;
    private readonly ILogger<AppointmentResolverJob> _logger;
    private static readonly TimeSpan Interval = TimeSpan.FromMinutes(5);

    public AppointmentResolverJob(
        IServiceProvider serviceProvider,
        ILogger<AppointmentResolverJob> logger)
    {
        _serviceProvider = serviceProvider;
        _logger = logger;
    }

    protected override async Task ExecuteAsync(CancellationToken stoppingToken)
    {
        _logger.LogInformation("AppointmentResolverJob starting — runs every {Interval} minutes.", Interval.TotalMinutes);

        while (!stoppingToken.IsCancellationRequested)
        {
            try
            {
                await ResolveOverdueAppointmentsAsync(stoppingToken);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "AppointmentResolverJob encountered an error.");
            }

            await Task.Delay(Interval, stoppingToken);
        }
    }

    private async Task ResolveOverdueAppointmentsAsync(CancellationToken ct)
    {
        using var scope = _serviceProvider.CreateScope();
        var context = scope.ServiceProvider.GetRequiredService<ApplicationDbContext>();
        var publisher = scope.ServiceProvider.GetRequiredService<IMessagePublisher>();

        var now = DateTime.UtcNow;

        // Pending past end time → Cancelled (admin never confirmed)
        var overduePending = await context.Appointments
            .Include(a => a.User)
            .Include(a => a.Staff)
            .Where(a => a.Status == AppointmentStatus.Pending &&
                        a.ScheduledAt.AddMinutes(a.DurationMinutes) < now)
            .ToListAsync(ct);

        foreach (var a in overduePending)
        {
            a.Status = AppointmentStatus.Cancelled;
            _logger.LogInformation("Appointment #{Id} auto-cancelled (pending, overdue).", a.Id);

            await publisher.PublishAsync(QueueNames.AppointmentStatusChanged,
                new AppointmentStatusChangedEvent
                {
                    Email = a.User.Email,
                    StaffName = $"{a.Staff.FirstName} {a.Staff.LastName}",
                    ScheduledAt = a.ScheduledAt,
                    NewStatus = "Cancelled"
                }, ct);
        }

        // Confirmed past end time → Completed (appointment was held)
        var overdueConfirmed = await context.Appointments
            .Include(a => a.User)
            .Include(a => a.Staff)
            .Where(a => a.Status == AppointmentStatus.Confirmed &&
                        a.ScheduledAt.AddMinutes(a.DurationMinutes) < now)
            .ToListAsync(ct);

        foreach (var a in overdueConfirmed)
        {
            a.Status = AppointmentStatus.Completed;
            _logger.LogInformation("Appointment #{Id} auto-completed (confirmed, overdue).", a.Id);

            await publisher.PublishAsync(QueueNames.AppointmentStatusChanged,
                new AppointmentStatusChangedEvent
                {
                    Email = a.User.Email,
                    StaffName = $"{a.Staff.FirstName} {a.Staff.LastName}",
                    ScheduledAt = a.ScheduledAt,
                    NewStatus = "Completed"
                }, ct);
        }

        if (overduePending.Count > 0 || overdueConfirmed.Count > 0)
        {
            await context.SaveChangesAsync(ct);
            _logger.LogInformation("Auto-resolved {Cancelled} cancelled + {Completed} completed appointments.",
                overduePending.Count, overdueConfirmed.Count);
        }
    }
}
