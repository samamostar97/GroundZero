using System.Text;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.IdentityModel.Tokens;
using GroundZero.Application.Common.Interfaces;
using GroundZero.Infrastructure.Auth;
using GroundZero.Infrastructure.Persistence;
using GroundZero.Infrastructure.Persistence.Repositories;
using GroundZero.Infrastructure.Services;

namespace GroundZero.Infrastructure;

public static class DependencyInjection
{
    public static IServiceCollection AddInfrastructure(this IServiceCollection services, IConfiguration cfg)
    {
        services.AddDbContext<AppDbContext>(o => o.UseSqlServer(cfg.GetConnectionString("DefaultConnection"),
            b => b.MigrationsAssembly(typeof(AppDbContext).Assembly.FullName)));
        services.AddIdentity<IdentityUser, IdentityRole>(o => { o.Password.RequireDigit = true; o.Password.RequiredLength = 6;
            o.Password.RequireNonAlphanumeric = false; o.User.RequireUniqueEmail = true; })
            .AddEntityFrameworkStores<AppDbContext>().AddDefaultTokenProviders();
        services.AddAuthentication(o => { o.DefaultAuthenticateScheme = JwtBearerDefaults.AuthenticationScheme;
            o.DefaultChallengeScheme = JwtBearerDefaults.AuthenticationScheme; })
            .AddJwtBearer(o => { o.TokenValidationParameters = new TokenValidationParameters
            { ValidateIssuer = true, ValidateAudience = true, ValidateLifetime = true, ValidateIssuerSigningKey = true,
              ValidIssuer = cfg["Jwt:Issuer"], ValidAudience = cfg["Jwt:Audience"],
              IssuerSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(cfg["Jwt:Key"]!)), ClockSkew = TimeSpan.Zero }; });
        services.AddScoped<JwtService>(); services.AddScoped<ICurrentUserService, CurrentUserService>();
        services.AddScoped<IEmailService, EmailService>(); services.AddScoped<IProductRepository, ProductRepository>();
        return services;
    }
}