using GroundZero.Domain.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace GroundZero.Infrastructure.Configurations;

public class WorkoutPlanConfiguration : IEntityTypeConfiguration<WorkoutPlan>
{
    public void Configure(EntityTypeBuilder<WorkoutPlan> builder)
    {
        builder.HasKey(wp => wp.Id);

        builder.Property(wp => wp.Name)
            .IsRequired()
            .HasMaxLength(200);

        builder.Property(wp => wp.Description)
            .HasMaxLength(1000);

        builder.HasOne(wp => wp.User)
            .WithMany()
            .HasForeignKey(wp => wp.UserId)
            .OnDelete(DeleteBehavior.Restrict);

        builder.HasMany(wp => wp.Days)
            .WithOne(d => d.WorkoutPlan)
            .HasForeignKey(d => d.WorkoutPlanId)
            .OnDelete(DeleteBehavior.Cascade);
    }
}
