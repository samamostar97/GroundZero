using GroundZero.Application.IServices;
using GroundZero.Messaging;
using GroundZero.Messaging.Events;

namespace GroundZero.Worker.Consumers;

public class AppointmentStatusConsumer : BaseConsumer<AppointmentStatusChangedEvent>
{
    public AppointmentStatusConsumer(
        RabbitMqConnection connection,
        IServiceProvider serviceProvider,
        ILogger<AppointmentStatusConsumer> logger)
        : base(connection, serviceProvider, QueueNames.AppointmentStatusChanged, logger) { }

    protected override async Task HandleAsync(AppointmentStatusChangedEvent message, IServiceProvider services, CancellationToken ct)
    {
        var emailService = services.GetRequiredService<IEmailService>();
        await emailService.SendAppointmentStatusAsync(message.Email, message.StaffName, message.ScheduledAt, message.NewStatus, ct);
    }
}
