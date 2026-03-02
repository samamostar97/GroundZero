using GroundZero.Domain.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace GroundZero.Infrastructure.Configurations;

public class StaffConfiguration : IEntityTypeConfiguration<Staff>
{
    public void Configure(EntityTypeBuilder<Staff> builder)
    {
        builder.HasKey(s => s.Id);

        builder.Property(s => s.FirstName)
            .IsRequired()
            .HasMaxLength(100);

        builder.Property(s => s.LastName)
            .IsRequired()
            .HasMaxLength(100);

        builder.Property(s => s.Email)
            .IsRequired()
            .HasMaxLength(256);

        builder.HasIndex(s => s.Email)
            .IsUnique()
            .HasFilter("[IsDeleted] = 0");

        builder.Property(s => s.Phone)
            .HasMaxLength(30);

        builder.Property(s => s.Bio)
            .HasMaxLength(2000);

        builder.Property(s => s.ProfileImageUrl)
            .HasMaxLength(500);

        builder.Property(s => s.StaffType)
            .IsRequired()
            .HasConversion<string>()
            .HasMaxLength(20);

        builder.Property(s => s.IsActive)
            .HasDefaultValue(true);
    }
}
