using GroundZero.Application.Features.Dashboard.DTOs;
using GroundZero.Application.IRepositories;
using MediatR;

namespace GroundZero.Application.Features.Dashboard.Queries;

public class GetActivityFeedQueryHandler : IRequestHandler<GetActivityFeedQuery, List<ActivityFeedItemResponse>>
{
    private readonly IDashboardRepository _dashboardRepository;

    public GetActivityFeedQueryHandler(IDashboardRepository dashboardRepository)
    {
        _dashboardRepository = dashboardRepository;
    }

    public async Task<List<ActivityFeedItemResponse>> Handle(GetActivityFeedQuery request, CancellationToken cancellationToken)
    {
        return await _dashboardRepository.GetActivityFeedAsync(request.Count, cancellationToken);
    }
}
