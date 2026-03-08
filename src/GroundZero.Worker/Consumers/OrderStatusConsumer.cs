using GroundZero.Application.IServices;
using GroundZero.Messaging;
using GroundZero.Messaging.Events;

namespace GroundZero.Worker.Consumers;

public class OrderStatusConsumer : BaseConsumer<OrderStatusChangedEvent>
{
    public OrderStatusConsumer(
        RabbitMqConnection connection,
        IServiceProvider serviceProvider,
        ILogger<OrderStatusConsumer> logger)
        : base(connection, serviceProvider, QueueNames.OrderStatusChanged, logger) { }

    protected override async Task HandleAsync(OrderStatusChangedEvent message, IServiceProvider services, CancellationToken ct)
    {
        var emailService = services.GetRequiredService<IEmailService>();
        await emailService.SendOrderStatusChangedAsync(message.Email, message.OrderId, message.NewStatus, ct);
    }
}
