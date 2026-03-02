using GroundZero.Application.Common;
using GroundZero.Domain.Entities;

namespace GroundZero.Application.IRepositories;

public interface IGymVisitRepository : IRepository<GymVisit>
{
    Task<GymVisit?> GetActiveVisitByUserIdAsync(int userId, CancellationToken cancellationToken = default);
    Task<GymVisit?> GetByIdWithUserAsync(int id, CancellationToken cancellationToken = default);
    Task<PagedResult<GymVisit>> GetUserVisitsPagedAsync(int userId, int pageNumber, int pageSize, CancellationToken cancellationToken = default);
    Task<PagedResult<GymVisit>> GetAllVisitsPagedAsync(string? search, int pageNumber, int pageSize, CancellationToken cancellationToken = default);
}
