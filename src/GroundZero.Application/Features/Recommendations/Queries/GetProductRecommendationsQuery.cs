using GroundZero.Application.Features.Recommendations.DTOs;
using MediatR;

namespace GroundZero.Application.Features.Recommendations.Queries;

public class GetProductRecommendationsQuery : IRequest<List<RecommendedProductResponse>>
{
    public int ProductId { get; set; }
    public int Limit { get; set; } = 10;
}
