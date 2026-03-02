using GroundZero.Application.Common;
using GroundZero.Application.IRepositories;
using GroundZero.Domain.Entities;
using GroundZero.Infrastructure.Data;
using Microsoft.EntityFrameworkCore;

namespace GroundZero.Infrastructure.Repositories;

public class GymVisitRepository : Repository<GymVisit>, IGymVisitRepository
{
    public GymVisitRepository(ApplicationDbContext context) : base(context) { }

    public async Task<GymVisit?> GetActiveVisitByUserIdAsync(int userId, CancellationToken cancellationToken = default)
    {
        return await _dbSet
            .Include(g => g.User)
            .FirstOrDefaultAsync(g => g.UserId == userId && g.CheckOutAt == null, cancellationToken);
    }

    public async Task<GymVisit?> GetByIdWithUserAsync(int id, CancellationToken cancellationToken = default)
    {
        return await _dbSet
            .Include(g => g.User)
            .FirstOrDefaultAsync(g => g.Id == id, cancellationToken);
    }

    public async Task<PagedResult<GymVisit>> GetUserVisitsPagedAsync(int userId, int pageNumber, int pageSize, CancellationToken cancellationToken = default)
    {
        var query = _dbSet
            .Include(g => g.User)
            .Where(g => g.UserId == userId);

        var totalCount = await query.CountAsync(cancellationToken);

        var items = await query
            .OrderByDescending(g => g.CheckInAt)
            .Skip((pageNumber - 1) * pageSize)
            .Take(pageSize)
            .ToListAsync(cancellationToken);

        return new PagedResult<GymVisit>
        {
            Items = items,
            TotalCount = totalCount,
            PageNumber = pageNumber,
            PageSize = pageSize
        };
    }

    public async Task<PagedResult<GymVisit>> GetAllVisitsPagedAsync(string? search, int pageNumber, int pageSize, CancellationToken cancellationToken = default)
    {
        var query = _dbSet.Include(g => g.User).AsQueryable();

        if (!string.IsNullOrWhiteSpace(search))
        {
            var searchLower = search.ToLower();
            query = query.Where(g =>
                g.User.FirstName.ToLower().Contains(searchLower) ||
                g.User.LastName.ToLower().Contains(searchLower));
        }

        var totalCount = await query.CountAsync(cancellationToken);

        var items = await query
            .OrderByDescending(g => g.CheckInAt)
            .Skip((pageNumber - 1) * pageSize)
            .Take(pageSize)
            .ToListAsync(cancellationToken);

        return new PagedResult<GymVisit>
        {
            Items = items,
            TotalCount = totalCount,
            PageNumber = pageNumber,
            PageSize = pageSize
        };
    }
}
