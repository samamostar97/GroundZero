using GroundZero.Domain.Entities;
using Microsoft.EntityFrameworkCore;

namespace GroundZero.Infrastructure.Data;

public class ApplicationDbContext : DbContext
{
    public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options) : base(options) { }

    public DbSet<User> Users => Set<User>();
    public DbSet<RefreshToken> RefreshTokens => Set<RefreshToken>();
    public DbSet<Staff> Staff => Set<Staff>();
    public DbSet<ProductCategory> ProductCategories => Set<ProductCategory>();
    public DbSet<Product> Products => Set<Product>();
    public DbSet<Order> Orders => Set<Order>();
    public DbSet<OrderItem> OrderItems => Set<OrderItem>();
    public DbSet<Appointment> Appointments => Set<Appointment>();
    public DbSet<Review> Reviews => Set<Review>();
    public DbSet<Exercise> Exercises => Set<Exercise>();
    public DbSet<WorkoutPlan> WorkoutPlans => Set<WorkoutPlan>();
    public DbSet<WorkoutDay> WorkoutDays => Set<WorkoutDay>();
    public DbSet<WorkoutExercise> WorkoutExercises => Set<WorkoutExercise>();
    public DbSet<WorkoutLog> WorkoutLogs => Set<WorkoutLog>();

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        base.OnModelCreating(modelBuilder);

        modelBuilder.ApplyConfigurationsFromAssembly(typeof(ApplicationDbContext).Assembly);

        foreach (var entityType in modelBuilder.Model.GetEntityTypes())
        {
            if (typeof(BaseEntity).IsAssignableFrom(entityType.ClrType))
            {
                var method = typeof(ApplicationDbContext)
                    .GetMethod(nameof(ApplySoftDeleteFilter), System.Reflection.BindingFlags.NonPublic | System.Reflection.BindingFlags.Static)!
                    .MakeGenericMethod(entityType.ClrType);

                method.Invoke(null, new object[] { modelBuilder });
            }
        }
    }

    private static void ApplySoftDeleteFilter<T>(ModelBuilder modelBuilder) where T : BaseEntity
    {
        modelBuilder.Entity<T>().HasQueryFilter(e => !e.IsDeleted);
    }
}
