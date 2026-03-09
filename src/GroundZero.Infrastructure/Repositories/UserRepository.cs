using GroundZero.Application.Common;
using GroundZero.Application.IRepositories;
using GroundZero.Domain.Entities;
using GroundZero.Domain.Enums;
using GroundZero.Infrastructure.Data;
using Microsoft.EntityFrameworkCore;

namespace GroundZero.Infrastructure.Repositories;

public class UserRepository : Repository<User>, IUserRepository
{
    public UserRepository(ApplicationDbContext context) : base(context) { }

    public async Task<User?> GetByEmailAsync(string email, CancellationToken cancellationToken = default)
    {
        return await _dbSet.FirstOrDefaultAsync(u => u.Email == email, cancellationToken);
    }

    public async Task<bool> EmailExistsAsync(string email, CancellationToken cancellationToken = default)
    {
        return await _dbSet.AnyAsync(u => u.Email == email.ToLower(), cancellationToken);
    }

    public async Task<PagedResult<User>> GetPagedAsync(string? search, string? sortBy, bool sortDescending, int pageNumber, int pageSize, bool? hasActiveMembership = null, CancellationToken cancellationToken = default)
    {
        var query = _dbSet.Where(u => u.Role == Role.User);

        if (!string.IsNullOrWhiteSpace(search))
        {
            var searchLower = search.ToLower();
            query = query.Where(u =>
                u.FirstName.ToLower().Contains(searchLower) ||
                u.LastName.ToLower().Contains(searchLower) ||
                u.Email.ToLower().Contains(searchLower));
        }

        if (hasActiveMembership == true)
        {
            var now = DateTime.UtcNow;
            query = query.Where(u => _context.UserMemberships.Any(m =>
                m.UserId == u.Id &&
                !m.IsDeleted &&
                m.Status == MembershipStatus.Active &&
                m.StartDate <= now &&
                m.EndDate >= now));
        }

        var totalCount = await query.CountAsync(cancellationToken);

        query = sortBy?.ToLower() switch
        {
            "id" => sortDescending ? query.OrderByDescending(u => u.Id) : query.OrderBy(u => u.Id),
            "firstname" => sortDescending ? query.OrderByDescending(u => u.FirstName) : query.OrderBy(u => u.FirstName),
            "email" => sortDescending ? query.OrderByDescending(u => u.Email) : query.OrderBy(u => u.Email),
            "level" => sortDescending ? query.OrderByDescending(u => u.Level) : query.OrderBy(u => u.Level),
            "xp" => sortDescending ? query.OrderByDescending(u => u.XP) : query.OrderBy(u => u.XP),
            _ => sortDescending ? query.OrderByDescending(u => u.CreatedAt) : query.OrderBy(u => u.CreatedAt),
        };

        var items = await query
            .Skip((pageNumber - 1) * pageSize)
            .Take(pageSize)
            .ToListAsync(cancellationToken);

        return new PagedResult<User>
        {
            Items = items,
            TotalCount = totalCount,
            PageNumber = pageNumber,
            PageSize = pageSize
        };
    }

    public async Task<PagedResult<User>> GetLeaderboardPagedAsync(int pageNumber, int pageSize, CancellationToken cancellationToken = default)
    {
        var query = _dbSet.Where(u => u.Role == Role.User);

        var totalCount = await query.CountAsync(cancellationToken);

        var items = await query
            .OrderByDescending(u => u.Level)
            .ThenByDescending(u => u.XP)
            .Skip((pageNumber - 1) * pageSize)
            .Take(pageSize)
            .ToListAsync(cancellationToken);

        return new PagedResult<User>
        {
            Items = items,
            TotalCount = totalCount,
            PageNumber = pageNumber,
            PageSize = pageSize
        };
    }

    public async Task<int> GetUserRankAsync(int userId, CancellationToken cancellationToken = default)
    {
        var user = await _dbSet.FirstOrDefaultAsync(u => u.Id == userId, cancellationToken);
        if (user == null) return 0;

        var rank = await _dbSet
            .Where(u => u.Role == Role.User)
            .CountAsync(u => u.Level > user.Level ||
                (u.Level == user.Level && u.XP > user.XP), cancellationToken);

        return rank + 1;
    }
}
