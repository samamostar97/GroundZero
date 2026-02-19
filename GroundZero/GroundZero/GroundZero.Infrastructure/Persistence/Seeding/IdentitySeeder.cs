using Microsoft.AspNetCore.Identity;
namespace GroundZero.Infrastructure.Persistence.Seeding;
public static class IdentitySeeder
{
    public static async Task SeedAsync(UserManager<IdentityUser> um, RoleManager<IdentityRole> rm)
    {
        foreach (var r in new[] { "Admin", "User" })
            if (!await rm.RoleExistsAsync(r)) await rm.CreateAsync(new IdentityRole(r));
        const string email = "admin@example.com";
        if (await um.FindByEmailAsync(email) is null)
        { var u = new IdentityUser { UserName = email, Email = email, EmailConfirmed = true };
          if ((await um.CreateAsync(u, "Admin123!")).Succeeded) await um.AddToRoleAsync(u, "Admin"); }
    }
}