using GroundZero.Domain.Base;
using GroundZero.Domain.Enums;

namespace GroundZero.Domain.Entities;

public class Product : AuditableEntity
{
    public string Name { get; set; } = string.Empty;
    public string? Description { get; set; }
    public decimal Price { get; set; }
    public int StockQuantity { get; set; }
    public string? ImageUrl { get; set; }
    public ProductStatus Status { get; set; } = ProductStatus.Active;
}