using GroundZero.Application.Features.Recommendations.DTOs;
using GroundZero.Application.IRepositories;
using GroundZero.Application.IServices;
using MediatR;

namespace GroundZero.Application.Features.Recommendations.Queries;

public class GetUserRecommendationsQueryHandler : IRequestHandler<GetUserRecommendationsQuery, List<RecommendedProductResponse>>
{
    private readonly IRecommendationRepository _recommendationRepository;
    private readonly ICurrentUserService _currentUserService;

    public GetUserRecommendationsQueryHandler(
        IRecommendationRepository recommendationRepository,
        ICurrentUserService currentUserService)
    {
        _recommendationRepository = recommendationRepository;
        _currentUserService = currentUserService;
    }

    public async Task<List<RecommendedProductResponse>> Handle(GetUserRecommendationsQuery query, CancellationToken cancellationToken)
    {
        var userId = _currentUserService.UserId
            ?? throw new UnauthorizedAccessException("Morate biti prijavljeni.");

        var recommendations = await _recommendationRepository.GetUserRecommendationsAsync(
            userId, query.Limit, cancellationToken);

        return recommendations
            .Select(r => r.Product.ToRecommendedResponse(r.CoPurchaseCount))
            .ToList();
    }
}
