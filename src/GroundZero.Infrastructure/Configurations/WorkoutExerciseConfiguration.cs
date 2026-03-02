using GroundZero.Domain.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace GroundZero.Infrastructure.Configurations;

public class WorkoutExerciseConfiguration : IEntityTypeConfiguration<WorkoutExercise>
{
    public void Configure(EntityTypeBuilder<WorkoutExercise> builder)
    {
        builder.HasKey(we => we.Id);

        builder.Property(we => we.Sets)
            .IsRequired();

        builder.Property(we => we.Reps)
            .IsRequired();

        builder.Property(we => we.Weight)
            .HasPrecision(10, 2);

        builder.Property(we => we.OrderIndex)
            .IsRequired()
            .HasDefaultValue(0);

        builder.HasOne(we => we.Exercise)
            .WithMany()
            .HasForeignKey(we => we.ExerciseId)
            .OnDelete(DeleteBehavior.Restrict);
    }
}
