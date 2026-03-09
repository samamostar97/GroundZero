using DotNetEnv;
using GroundZero.Application.IServices;
using GroundZero.Infrastructure.Data;
using GroundZero.Infrastructure.Services;
using GroundZero.Messaging;
using GroundZero.Worker.Consumers;
using GroundZero.Worker.ScheduledJobs;
using Microsoft.EntityFrameworkCore;

// Load .env file (skipped in Docker — env vars injected via docker-compose env_file)
var envPath = Path.Combine(Directory.GetCurrentDirectory(), "..", "..", ".env");
if (File.Exists(envPath))
    Env.Load(envPath);

var builder = Host.CreateApplicationBuilder(args);

// Database (needed by scheduled jobs)
var dbHost = Environment.GetEnvironmentVariable("DB_HOST") ?? "localhost,1433";
var dbName = Environment.GetEnvironmentVariable("DB_NAME") ?? "GroundZeroDb";
var dbUser = Environment.GetEnvironmentVariable("DB_USER") ?? "sa";
var dbPassword = Environment.GetEnvironmentVariable("DB_PASSWORD") ?? "";
var connectionString = $"Server={dbHost};Database={dbName};User Id={dbUser};Password={dbPassword};TrustServerCertificate=True;";

builder.Services.AddDbContext<ApplicationDbContext>(options =>
    options.UseSqlServer(connectionString));

// RabbitMQ connection (singleton — shared by all consumers and publishers)
builder.Services.AddSingleton<RabbitMqConnection>();
builder.Services.AddSingleton<IMessagePublisher, RabbitMqPublisher>();

// Email service
builder.Services.AddScoped<IEmailService, EmailService>();

// Consumers
builder.Services.AddHostedService<OrderCreatedConsumer>();
builder.Services.AddHostedService<OrderStatusConsumer>();
builder.Services.AddHostedService<AppointmentStatusConsumer>();
builder.Services.AddHostedService<LevelUpConsumer>();
builder.Services.AddHostedService<MembershipExpiredConsumer>();
builder.Services.AddHostedService<MembershipCancelledConsumer>();

// Scheduled jobs
builder.Services.AddHostedService<AppointmentResolverJob>();
builder.Services.AddHostedService<MembershipResolverJob>();

var host = builder.Build();
host.Run();
