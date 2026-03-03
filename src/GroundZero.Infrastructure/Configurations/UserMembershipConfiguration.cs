using GroundZero.Domain.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace GroundZero.Infrastructure.Configurations;

public class UserMembershipConfiguration : IEntityTypeConfiguration<UserMembership>
{
    public void Configure(EntityTypeBuilder<UserMembership> builder)
    {
        builder.HasKey(m => m.Id);

        builder.Property(m => m.Status)
            .IsRequired()
            .HasConversion<string>()
            .HasMaxLength(50);

        builder.HasOne(m => m.User)
            .WithMany()
            .HasForeignKey(m => m.UserId)
            .OnDelete(DeleteBehavior.Restrict);

        builder.HasOne(m => m.MembershipPlan)
            .WithMany()
            .HasForeignKey(m => m.MembershipPlanId)
            .OnDelete(DeleteBehavior.Restrict);
    }
}
