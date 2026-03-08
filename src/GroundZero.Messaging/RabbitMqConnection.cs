using RabbitMQ.Client;

namespace GroundZero.Messaging;

public class RabbitMqConnection : IAsyncDisposable
{
    private readonly string _host;
    private readonly int _port;
    private readonly string _user;
    private readonly string _password;
    private IConnection? _connection;
    private IChannel? _channel;
    private readonly SemaphoreSlim _lock = new(1, 1);

    public RabbitMqConnection()
    {
        _host = Environment.GetEnvironmentVariable("RABBITMQ_HOST") ?? "localhost";
        _port = int.Parse(Environment.GetEnvironmentVariable("RABBITMQ_PORT") ?? "5672");
        _user = Environment.GetEnvironmentVariable("RABBITMQ_USER") ?? "guest";
        _password = Environment.GetEnvironmentVariable("RABBITMQ_PASSWORD") ?? "guest";
    }

    public async Task<IChannel> GetChannelAsync(CancellationToken ct = default)
    {
        if (_channel is { IsOpen: true })
            return _channel;

        await _lock.WaitAsync(ct);
        try
        {
            if (_channel is { IsOpen: true })
                return _channel;

            if (_connection is not { IsOpen: true })
            {
                var factory = new ConnectionFactory
                {
                    HostName = _host,
                    Port = _port,
                    UserName = _user,
                    Password = _password
                };

                // Retry connection up to 10 times (for Docker startup)
                for (int i = 0; i < 10; i++)
                {
                    try
                    {
                        _connection = await factory.CreateConnectionAsync(ct);
                        break;
                    }
                    catch
                    {
                        if (i == 9) throw;
                        await Task.Delay(3000, ct);
                    }
                }
            }

            _channel = await _connection!.CreateChannelAsync(cancellationToken: ct);
            return _channel;
        }
        finally
        {
            _lock.Release();
        }
    }

    public async ValueTask DisposeAsync()
    {
        if (_channel is not null)
            await _channel.CloseAsync();
        if (_connection is not null)
            await _connection.CloseAsync();
    }
}
