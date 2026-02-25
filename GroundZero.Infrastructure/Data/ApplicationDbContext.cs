using GroundZero.Application.IServices;
using GroundZero.Core.Entities;
using Microsoft.EntityFrameworkCore;

namespace GroundZero.Infrastructure.Data;

public class ApplicationDbContext : DbContext
{
    private readonly IDateTimeService _dateTimeService;

    public ApplicationDbContext(
        DbContextOptions<ApplicationDbContext> options,
        IDateTimeService dateTimeService)
        : base(options)
    {
        _dateTimeService = dateTimeService;
    }

    public override async Task<int> SaveChangesAsync(CancellationToken cancellationToken = default)
    {
        foreach (var entry in ChangeTracker.Entries<BaseEntity>())
        {
            switch (entry.State)
            {
                case EntityState.Added:
                    entry.Entity.CreatedAt = _dateTimeService.Now;
                    break;
                case EntityState.Modified:
                    entry.Entity.UpdatedAt = _dateTimeService.Now;
                    break;
            }
        }

        return await base.SaveChangesAsync(cancellationToken);
    }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.ApplyConfigurationsFromAssembly(typeof(ApplicationDbContext).Assembly);
        base.OnModelCreating(modelBuilder);
    }
}
