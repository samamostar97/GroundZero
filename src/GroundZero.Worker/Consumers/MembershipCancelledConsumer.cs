using GroundZero.Application.IServices;
using GroundZero.Messaging;
using GroundZero.Messaging.Events;

namespace GroundZero.Worker.Consumers;

public class MembershipCancelledConsumer : BaseConsumer<MembershipCancelledEvent>
{
    public MembershipCancelledConsumer(
        RabbitMqConnection connection,
        IServiceProvider serviceProvider,
        ILogger<MembershipCancelledConsumer> logger)
        : base(connection, serviceProvider, QueueNames.MembershipCancelled, logger) { }

    protected override async Task HandleAsync(MembershipCancelledEvent message, IServiceProvider services, CancellationToken ct)
    {
        var emailService = services.GetRequiredService<IEmailService>();
        await emailService.SendMembershipCancelledAsync(message.Email, message.UserName, message.PlanName, message.CancelledAt, ct);
    }
}
