using GroundZero.Domain.Enums;
namespace GroundZero.Application.Features.Products.Filters;
public class ProductFilter
{
    public string? SearchTerm { get; set; }
    public ProductStatus? Status { get; set; }
    public decimal? MinPrice { get; set; }
    public decimal? MaxPrice { get; set; }
    public int Page { get; set; } = 1;
    public int PageSize { get; set; } = 10;
    public string? SortBy { get; set; }
    public bool SortDescending { get; set; } = false;
}