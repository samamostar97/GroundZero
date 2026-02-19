using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using GroundZero.Domain.Entities;

namespace GroundZero.Infrastructure.Persistence.Configurations;

public class ProductConfiguration : IEntityTypeConfiguration<Product>
{
    public void Configure(EntityTypeBuilder<Product> b)
    {
        b.HasKey(p => p.Id);
        b.Property(p => p.Name).IsRequired().HasMaxLength(200);
        b.Property(p => p.Description).HasMaxLength(2000);
        b.Property(p => p.Price).HasPrecision(18, 2);
        b.Property(p => p.ImageUrl).HasMaxLength(500);
        b.Property(p => p.Status).HasConversion<string>().HasMaxLength(50);
        b.HasIndex(p => p.Name); b.HasIndex(p => p.Status);
    }
}