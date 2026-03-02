using GroundZero.Domain.Entities;

namespace GroundZero.Application.Features.Recommendations.DTOs;

public static class RecommendationMappingExtensions
{
    public static RecommendedProductResponse ToRecommendedResponse(this Product product, int coPurchaseCount)
    {
        return new RecommendedProductResponse
        {
            Id = product.Id,
            Name = product.Name,
            Description = product.Description,
            Price = product.Price,
            ImageUrl = product.ImageUrl,
            StockQuantity = product.StockQuantity,
            CategoryId = product.CategoryId,
            CategoryName = product.Category?.Name ?? string.Empty,
            CreatedAt = product.CreatedAt,
            CoPurchaseCount = coPurchaseCount
        };
    }
}
