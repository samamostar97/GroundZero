using GroundZero.Application.IServices;
using GroundZero.Messaging;
using GroundZero.Messaging.Events;

namespace GroundZero.Worker.Consumers;

public class LevelUpConsumer : BaseConsumer<UserLevelUpEvent>
{
    public LevelUpConsumer(
        RabbitMqConnection connection,
        IServiceProvider serviceProvider,
        ILogger<LevelUpConsumer> logger)
        : base(connection, serviceProvider, QueueNames.UserLevelUp, logger) { }

    protected override async Task HandleAsync(UserLevelUpEvent message, IServiceProvider services, CancellationToken ct)
    {
        var emailService = services.GetRequiredService<IEmailService>();
        await emailService.SendLevelUpAsync(message.Email, message.UserName, message.NewLevel, ct);
    }
}
