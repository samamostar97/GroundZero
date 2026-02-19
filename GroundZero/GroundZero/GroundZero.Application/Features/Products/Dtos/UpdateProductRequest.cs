using GroundZero.Domain.Enums;
namespace GroundZero.Application.Features.Products.Dtos;
public class UpdateProductRequest
{
    public string Name { get; set; } = string.Empty;
    public string? Description { get; set; }
    public decimal Price { get; set; }
    public int StockQuantity { get; set; }
    public string? ImageUrl { get; set; }
    public ProductStatus Status { get; set; }
}