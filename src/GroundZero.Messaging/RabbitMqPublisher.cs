using System.Text;
using System.Text.Json;
using RabbitMQ.Client;

namespace GroundZero.Messaging;

public class RabbitMqPublisher : IMessagePublisher
{
    private readonly RabbitMqConnection _connection;

    public RabbitMqPublisher(RabbitMqConnection connection)
    {
        _connection = connection;
    }

    public async Task PublishAsync<T>(string queueName, T message, CancellationToken ct = default)
    {
        try
        {
            var channel = await _connection.GetChannelAsync(ct);

            await channel.QueueDeclareAsync(
                queue: queueName,
                durable: true,
                exclusive: false,
                autoDelete: false,
                arguments: null,
                cancellationToken: ct);

            var json = JsonSerializer.Serialize(message);
            var body = Encoding.UTF8.GetBytes(json);

            var properties = new BasicProperties
            {
                Persistent = true,
                ContentType = "application/json"
            };

            await channel.BasicPublishAsync(
                exchange: string.Empty,
                routingKey: queueName,
                mandatory: false,
                basicProperties: properties,
                body: body,
                cancellationToken: ct);
        }
        catch (Exception)
        {
            // RabbitMQ unavailable — silently skip, don't break the main request
        }
    }
}
