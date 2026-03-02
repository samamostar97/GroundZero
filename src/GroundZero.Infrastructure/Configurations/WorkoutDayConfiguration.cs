using GroundZero.Domain.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace GroundZero.Infrastructure.Configurations;

public class WorkoutDayConfiguration : IEntityTypeConfiguration<WorkoutDay>
{
    public void Configure(EntityTypeBuilder<WorkoutDay> builder)
    {
        builder.HasKey(wd => wd.Id);

        builder.Property(wd => wd.DayOfWeek)
            .IsRequired()
            .HasConversion<string>()
            .HasMaxLength(20);

        builder.Property(wd => wd.Name)
            .IsRequired()
            .HasMaxLength(200);

        builder.HasMany(wd => wd.Exercises)
            .WithOne(we => we.WorkoutDay)
            .HasForeignKey(we => we.WorkoutDayId)
            .OnDelete(DeleteBehavior.Cascade);
    }
}
