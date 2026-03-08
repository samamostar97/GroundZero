using GroundZero.Application.Features.Dashboard.DTOs;

namespace GroundZero.Application.IRepositories;

public interface IDashboardRepository
{
    Task<DashboardResponse> GetDashboardDataAsync(CancellationToken cancellationToken = default);
}
