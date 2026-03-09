using GroundZero.Application.IServices;
using GroundZero.Messaging;
using GroundZero.Messaging.Events;

namespace GroundZero.Worker.Consumers;

public class MembershipExpiredConsumer : BaseConsumer<MembershipExpiredEvent>
{
    public MembershipExpiredConsumer(
        RabbitMqConnection connection,
        IServiceProvider serviceProvider,
        ILogger<MembershipExpiredConsumer> logger)
        : base(connection, serviceProvider, QueueNames.MembershipExpired, logger) { }

    protected override async Task HandleAsync(MembershipExpiredEvent message, IServiceProvider services, CancellationToken ct)
    {
        var emailService = services.GetRequiredService<IEmailService>();
        await emailService.SendMembershipExpiredAsync(message.Email, message.UserName, message.PlanName, message.ExpiredAt, ct);
    }
}
