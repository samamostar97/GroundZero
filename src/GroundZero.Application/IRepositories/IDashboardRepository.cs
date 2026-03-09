using GroundZero.Application.Features.Dashboard.DTOs;

namespace GroundZero.Application.IRepositories;


public interface IDashboardRepository
{
    Task<DashboardResponse> GetDashboardDataAsync(CancellationToken cancellationToken = default);
    Task<List<ActivityFeedItemResponse>> GetActivityFeedAsync(int count = 20, CancellationToken cancellationToken = default);
}
