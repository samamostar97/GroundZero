using GroundZero.Application.IServices;
using GroundZero.Messaging;
using GroundZero.Messaging.Events;

namespace GroundZero.Worker.Consumers;

public class OrderCreatedConsumer : BaseConsumer<OrderCreatedEvent>
{
    public OrderCreatedConsumer(
        RabbitMqConnection connection,
        IServiceProvider serviceProvider,
        ILogger<OrderCreatedConsumer> logger)
        : base(connection, serviceProvider, QueueNames.OrderCreated, logger) { }

    protected override async Task HandleAsync(OrderCreatedEvent message, IServiceProvider services, CancellationToken ct)
    {
        var emailService = services.GetRequiredService<IEmailService>();
        await emailService.SendOrderConfirmationAsync(message.Email, message.OrderId, message.TotalAmount, message.Items, ct);
    }
}
