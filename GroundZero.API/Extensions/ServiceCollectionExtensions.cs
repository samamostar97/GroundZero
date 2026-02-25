using System.Reflection;
using FluentValidation;
using GroundZero.Application.Common.Behaviours;
using GroundZero.Application.IServices;
using GroundZero.Infrastructure.Data;
using GroundZero.Infrastructure.Services;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace GroundZero.API.Extensions;

public static class ServiceCollectionExtensions
{
    public static IServiceCollection AddInfrastructure(this IServiceCollection services)
    {
        var connectionString = Environment.GetEnvironmentVariable("ConnectionStrings__DefaultConnection")
            ?? throw new InvalidOperationException("Connection string 'DefaultConnection' not found.");

        services.AddDbContext<ApplicationDbContext>(options =>
            options.UseSqlServer(
                connectionString,
                b => b.MigrationsAssembly(typeof(ApplicationDbContext).Assembly.FullName)));

        services.AddSingleton<IDateTimeService, DateTimeService>();

        // Register repositories here
        // services.AddScoped<IUserRepository, UserRepository>();

        // Register services here
        // services.AddScoped<IEmailService, EmailService>();

        services.AddHttpContextAccessor();

        var applicationAssembly = typeof(ValidationBehaviour<,>).Assembly;

        services.AddMediatR(cfg =>
        {
            cfg.RegisterServicesFromAssembly(applicationAssembly);
            cfg.AddBehavior(typeof(IPipelineBehavior<,>), typeof(ValidationBehaviour<,>));
        });

        services.AddValidatorsFromAssembly(applicationAssembly);

        return services;
    }

    public static IServiceCollection AddSwaggerWithAuth(this IServiceCollection services)
    {
        services.AddEndpointsApiExplorer();
        services.AddSwaggerGen();

        return services;
    }
}
