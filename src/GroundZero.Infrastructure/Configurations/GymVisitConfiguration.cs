using GroundZero.Domain.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace GroundZero.Infrastructure.Configurations;

public class GymVisitConfiguration : IEntityTypeConfiguration<GymVisit>
{
    public void Configure(EntityTypeBuilder<GymVisit> builder)
    {
        builder.HasKey(g => g.Id);

        builder.Property(g => g.CheckInAt)
            .IsRequired();

        builder.HasOne(g => g.User)
            .WithMany()
            .HasForeignKey(g => g.UserId)
            .OnDelete(DeleteBehavior.Restrict);
    }
}
