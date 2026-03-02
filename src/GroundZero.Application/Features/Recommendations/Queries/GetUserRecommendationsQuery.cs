using GroundZero.Application.Features.Recommendations.DTOs;
using MediatR;

namespace GroundZero.Application.Features.Recommendations.Queries;

public class GetUserRecommendationsQuery : IRequest<List<RecommendedProductResponse>>
{
    public int Limit { get; set; } = 10;
}
