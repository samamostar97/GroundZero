using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;
using GroundZero.Domain.Base;
using GroundZero.Domain.Entities;

namespace GroundZero.Infrastructure.Persistence;

public class AppDbContext : IdentityDbContext<IdentityUser>
{
    public AppDbContext(DbContextOptions<AppDbContext> options) : base(options) { }
    public DbSet<Product> Products => Set<Product>();

    protected override void OnModelCreating(ModelBuilder b)
    { base.OnModelCreating(b); b.ApplyConfigurationsFromAssembly(typeof(AppDbContext).Assembly); }

    public override Task<int> SaveChangesAsync(CancellationToken ct = default)
    {
        foreach (var e in ChangeTracker.Entries<AuditableEntity>())
            switch (e.State) {
                case EntityState.Added: e.Entity.CreatedAt = DateTime.UtcNow; break;
                case EntityState.Modified: e.Entity.UpdatedAt = DateTime.UtcNow; break;
            }
        return base.SaveChangesAsync(ct);
    }
}