using GroundZero.Domain.Entities;
using GroundZero.Domain.Enums;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace GroundZero.Infrastructure.Configurations;

public class UserConfiguration : IEntityTypeConfiguration<User>
{
    public void Configure(EntityTypeBuilder<User> builder)
    {
        builder.HasKey(u => u.Id);

        builder.Property(u => u.FirstName)
            .IsRequired()
            .HasMaxLength(100);

        builder.Property(u => u.LastName)
            .IsRequired()
            .HasMaxLength(100);

        builder.Property(u => u.Email)
            .IsRequired()
            .HasMaxLength(256);

        builder.HasIndex(u => u.Email)
            .IsUnique()
            .HasFilter("[IsDeleted] = 0");

        builder.Property(u => u.PasswordHash)
            .IsRequired();

        builder.Property(u => u.ProfileImageUrl)
            .HasMaxLength(500);

        builder.Property(u => u.Role)
            .IsRequired()
            .HasConversion<string>()
            .HasMaxLength(20);

        builder.Property(u => u.Level)
            .HasDefaultValue(1);

        builder.Property(u => u.XP)
            .HasDefaultValue(0);

        builder.Property(u => u.TotalGymMinutes)
            .HasDefaultValue(0);
    }
}
