using GroundZero.Domain.Enums;
using GroundZero.Infrastructure.Data;
using GroundZero.Messaging;
using GroundZero.Messaging.Events;
using Microsoft.EntityFrameworkCore;

namespace GroundZero.Worker.ScheduledJobs;

public class MembershipResolverJob : BackgroundService
{
    private readonly IServiceProvider _serviceProvider;
    private readonly ILogger<MembershipResolverJob> _logger;
    private static readonly TimeSpan Interval = TimeSpan.FromMinutes(30);

    public MembershipResolverJob(
        IServiceProvider serviceProvider,
        ILogger<MembershipResolverJob> logger)
    {
        _serviceProvider = serviceProvider;
        _logger = logger;
    }

    protected override async Task ExecuteAsync(CancellationToken stoppingToken)
    {
        _logger.LogInformation("MembershipResolverJob starting — runs every {Interval} minutes.", Interval.TotalMinutes);

        while (!stoppingToken.IsCancellationRequested)
        {
            try
            {
                await ExpireOverdueMembershipsAsync(stoppingToken);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "MembershipResolverJob encountered an error.");
            }

            await Task.Delay(Interval, stoppingToken);
        }
    }

    private async Task ExpireOverdueMembershipsAsync(CancellationToken ct)
    {
        using var scope = _serviceProvider.CreateScope();
        var context = scope.ServiceProvider.GetRequiredService<ApplicationDbContext>();
        var publisher = scope.ServiceProvider.GetRequiredService<IMessagePublisher>();

        var now = DateTime.UtcNow;

        var overdue = await context.UserMemberships
            .Include(m => m.User)
            .Include(m => m.MembershipPlan)
            .Where(m => m.Status == MembershipStatus.Active && m.EndDate < now)
            .ToListAsync(ct);

        foreach (var m in overdue)
        {
            m.Status = MembershipStatus.Expired;
            _logger.LogInformation("Membership #{Id} auto-expired for user {User}.", m.Id, m.User.Email);

            await publisher.PublishAsync(QueueNames.MembershipExpired,
                new MembershipExpiredEvent
                {
                    Email = m.User.Email,
                    UserName = $"{m.User.FirstName} {m.User.LastName}",
                    PlanName = m.MembershipPlan.Name,
                    ExpiredAt = m.EndDate
                }, ct);
        }

        if (overdue.Count > 0)
        {
            await context.SaveChangesAsync(ct);
            _logger.LogInformation("Auto-expired {Count} memberships.", overdue.Count);
        }
    }
}
