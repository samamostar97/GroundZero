using System.Text;
using System.Text.Json;
using GroundZero.Messaging;
using RabbitMQ.Client;
using RabbitMQ.Client.Events;

namespace GroundZero.Worker.Consumers;

public abstract class BaseConsumer<T> : BackgroundService
{
    private readonly RabbitMqConnection _connection;
    private readonly IServiceProvider _serviceProvider;
    private readonly string _queueName;
    private readonly ILogger _logger;

    protected BaseConsumer(
        RabbitMqConnection connection,
        IServiceProvider serviceProvider,
        string queueName,
        ILogger logger)
    {
        _connection = connection;
        _serviceProvider = serviceProvider;
        _queueName = queueName;
        _logger = logger;
    }

    protected override async Task ExecuteAsync(CancellationToken stoppingToken)
    {
        _logger.LogInformation("Consumer {Queue} starting...", _queueName);

        var channel = await _connection.GetChannelAsync(stoppingToken);

        await channel.QueueDeclareAsync(
            queue: _queueName,
            durable: true,
            exclusive: false,
            autoDelete: false,
            arguments: null,
            cancellationToken: stoppingToken);

        await channel.BasicQosAsync(prefetchSize: 0, prefetchCount: 1, global: false, cancellationToken: stoppingToken);

        var consumer = new AsyncEventingBasicConsumer(channel);
        consumer.ReceivedAsync += async (_, ea) =>
        {
            try
            {
                var json = Encoding.UTF8.GetString(ea.Body.ToArray());
                var message = JsonSerializer.Deserialize<T>(json);

                if (message != null)
                {
                    using var scope = _serviceProvider.CreateScope();
                    await HandleAsync(message, scope.ServiceProvider, stoppingToken);
                }

                await channel.BasicAckAsync(ea.DeliveryTag, multiple: false, stoppingToken);
                _logger.LogInformation("Consumer {Queue} processed message successfully.", _queueName);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Consumer {Queue} failed to process message.", _queueName);
                await channel.BasicNackAsync(ea.DeliveryTag, multiple: false, requeue: true, cancellationToken: stoppingToken);
            }
        };

        await channel.BasicConsumeAsync(
            queue: _queueName,
            autoAck: false,
            consumer: consumer,
            cancellationToken: stoppingToken);

        _logger.LogInformation("Consumer {Queue} is listening.", _queueName);

        // Keep alive until cancelled
        await Task.Delay(Timeout.Infinite, stoppingToken);
    }

    protected abstract Task HandleAsync(T message, IServiceProvider services, CancellationToken ct);
}
