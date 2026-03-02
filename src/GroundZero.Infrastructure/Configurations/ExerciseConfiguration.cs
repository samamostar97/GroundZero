using GroundZero.Domain.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace GroundZero.Infrastructure.Configurations;

public class ExerciseConfiguration : IEntityTypeConfiguration<Exercise>
{
    public void Configure(EntityTypeBuilder<Exercise> builder)
    {
        builder.HasKey(e => e.Id);

        builder.Property(e => e.Name)
            .IsRequired()
            .HasMaxLength(200);

        builder.Property(e => e.MuscleGroup)
            .IsRequired()
            .HasConversion<string>()
            .HasMaxLength(50);

        builder.Property(e => e.Description)
            .HasMaxLength(1000);
    }
}
