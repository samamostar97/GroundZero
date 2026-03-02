using GroundZero.Application.Common;
using GroundZero.Domain.Entities;

namespace GroundZero.Application.IRepositories;

public interface IWorkoutLogRepository : IRepository<WorkoutLog>
{
    Task<WorkoutLog?> GetByIdWithDetailsAsync(int id, CancellationToken cancellationToken = default);
    Task<PagedResult<WorkoutLog>> GetUserLogsPagedAsync(int userId, int pageNumber, int pageSize, CancellationToken cancellationToken = default);
}
