using GroundZero.Application.Features.Recommendations.DTOs;
using GroundZero.Application.IRepositories;
using MediatR;

namespace GroundZero.Application.Features.Recommendations.Queries;

public class GetProductRecommendationsQueryHandler : IRequestHandler<GetProductRecommendationsQuery, List<RecommendedProductResponse>>
{
    private readonly IRecommendationRepository _recommendationRepository;

    public GetProductRecommendationsQueryHandler(IRecommendationRepository recommendationRepository)
    {
        _recommendationRepository = recommendationRepository;
    }

    public async Task<List<RecommendedProductResponse>> Handle(GetProductRecommendationsQuery query, CancellationToken cancellationToken)
    {
        var recommendations = await _recommendationRepository.GetProductRecommendationsAsync(
            query.ProductId, query.Limit, cancellationToken);

        return recommendations
            .Select(r => r.Product.ToRecommendedResponse(r.CoPurchaseCount))
            .ToList();
    }
}
