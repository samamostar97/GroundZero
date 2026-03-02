using GroundZero.Domain.Entities;
using GroundZero.Domain.Enums;
using Microsoft.EntityFrameworkCore;

namespace GroundZero.Infrastructure.Data;

public static class DataSeeder
{
    public static async Task SeedAsync(ApplicationDbContext context)
    {
        if (await context.Users.AnyAsync(u => u.Role == Role.Admin))
            return;

        var adminUsername = Environment.GetEnvironmentVariable("ADMIN_USERNAME") ?? "desktop";
        var adminPassword = Environment.GetEnvironmentVariable("ADMIN_PASSWORD") ?? "test";

        var admin = new User
        {
            FirstName = "Admin",
            LastName = "Admin",
            Email = adminUsername,
            PasswordHash = BCrypt.Net.BCrypt.HashPassword(adminPassword),
            Role = Role.Admin,
            CreatedAt = DateTime.UtcNow
        };

        await context.Users.AddAsync(admin);
        await context.SaveChangesAsync();
    }
}
