using GroundZero.Application.Common;
using GroundZero.Application.IRepositories;
using GroundZero.Domain.Entities;
using GroundZero.Infrastructure.Data;
using Microsoft.EntityFrameworkCore;

namespace GroundZero.Infrastructure.Repositories;

public class WorkoutLogRepository : Repository<WorkoutLog>, IWorkoutLogRepository
{
    public WorkoutLogRepository(ApplicationDbContext context) : base(context) { }

    public async Task<WorkoutLog?> GetByIdWithDetailsAsync(int id, CancellationToken cancellationToken = default)
    {
        return await _dbSet
            .Include(wl => wl.User)
            .Include(wl => wl.WorkoutDay)
                .ThenInclude(d => d.WorkoutPlan)
            .FirstOrDefaultAsync(wl => wl.Id == id, cancellationToken);
    }

    public async Task<PagedResult<WorkoutLog>> GetUserLogsPagedAsync(
        int userId, int pageNumber, int pageSize,
        CancellationToken cancellationToken = default)
    {
        var query = _dbSet
            .Include(wl => wl.WorkoutDay)
                .ThenInclude(d => d.WorkoutPlan)
            .Where(wl => wl.UserId == userId);

        var totalCount = await query.CountAsync(cancellationToken);

        var items = await query
            .OrderByDescending(wl => wl.StartedAt)
            .Skip((pageNumber - 1) * pageSize)
            .Take(pageSize)
            .ToListAsync(cancellationToken);

        return new PagedResult<WorkoutLog>
        {
            Items = items,
            TotalCount = totalCount,
            PageNumber = pageNumber,
            PageSize = pageSize
        };
    }
}
