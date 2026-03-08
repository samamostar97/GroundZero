using DotNetEnv;
using GroundZero.Application.IServices;
using GroundZero.Infrastructure.Services;
using GroundZero.Messaging;
using GroundZero.Worker.Consumers;

// Load .env file (skipped in Docker — env vars injected via docker-compose env_file)
var envPath = Path.Combine(Directory.GetCurrentDirectory(), "..", "..", ".env");
if (File.Exists(envPath))
    Env.Load(envPath);

var builder = Host.CreateApplicationBuilder(args);

// RabbitMQ connection (singleton — shared by all consumers)
builder.Services.AddSingleton<RabbitMqConnection>();

// Email service
builder.Services.AddScoped<IEmailService, EmailService>();

// Consumers
builder.Services.AddHostedService<OrderCreatedConsumer>();
builder.Services.AddHostedService<OrderStatusConsumer>();
builder.Services.AddHostedService<AppointmentStatusConsumer>();
builder.Services.AddHostedService<LevelUpConsumer>();

var host = builder.Build();
host.Run();
