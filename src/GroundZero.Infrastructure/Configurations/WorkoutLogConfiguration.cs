using GroundZero.Domain.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace GroundZero.Infrastructure.Configurations;

public class WorkoutLogConfiguration : IEntityTypeConfiguration<WorkoutLog>
{
    public void Configure(EntityTypeBuilder<WorkoutLog> builder)
    {
        builder.HasKey(wl => wl.Id);

        builder.Property(wl => wl.StartedAt)
            .IsRequired();

        builder.Property(wl => wl.Notes)
            .HasMaxLength(1000);

        builder.HasOne(wl => wl.User)
            .WithMany()
            .HasForeignKey(wl => wl.UserId)
            .OnDelete(DeleteBehavior.Restrict);

        builder.HasOne(wl => wl.WorkoutDay)
            .WithMany()
            .HasForeignKey(wl => wl.WorkoutDayId)
            .OnDelete(DeleteBehavior.Restrict);
    }
}
