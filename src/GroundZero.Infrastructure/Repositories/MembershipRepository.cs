using GroundZero.Application.Common;
using GroundZero.Application.IRepositories;
using GroundZero.Domain.Entities;
using GroundZero.Domain.Enums;
using GroundZero.Infrastructure.Data;
using Microsoft.EntityFrameworkCore;

namespace GroundZero.Infrastructure.Repositories;

public class MembershipRepository : Repository<UserMembership>, IMembershipRepository
{
    public MembershipRepository(ApplicationDbContext context) : base(context) { }

    public async Task<UserMembership?> GetByIdWithDetailsAsync(int id, CancellationToken cancellationToken = default)
    {
        return await _dbSet
            .Include(m => m.User)
            .Include(m => m.MembershipPlan)
            .FirstOrDefaultAsync(m => m.Id == id, cancellationToken);
    }

    public async Task<UserMembership?> GetCurrentMembershipForUserAsync(int userId, CancellationToken cancellationToken = default)
    {
        // Auto-expire overdue memberships for this user
        await ExpireOverdueMembershipsAsync(cancellationToken);

        // Try to find an active membership first
        var active = await _dbSet
            .Include(m => m.User)
            .Include(m => m.MembershipPlan)
            .Where(m => m.UserId == userId && m.Status == MembershipStatus.Active)
            .OrderByDescending(m => m.EndDate)
            .FirstOrDefaultAsync(cancellationToken);

        if (active != null)
            return active;

        // If no active, return the most recent one
        return await _dbSet
            .Include(m => m.User)
            .Include(m => m.MembershipPlan)
            .Where(m => m.UserId == userId)
            .OrderByDescending(m => m.EndDate)
            .FirstOrDefaultAsync(cancellationToken);
    }

    public async Task<PagedResult<UserMembership>> GetUserMembershipHistoryPagedAsync(
        int userId, int pageNumber, int pageSize, CancellationToken cancellationToken = default)
    {
        var query = _dbSet
            .Include(m => m.User)
            .Include(m => m.MembershipPlan)
            .Where(m => m.UserId == userId);

        var totalCount = await query.CountAsync(cancellationToken);

        var items = await query
            .OrderByDescending(m => m.StartDate)
            .Skip((pageNumber - 1) * pageSize)
            .Take(pageSize)
            .ToListAsync(cancellationToken);

        return new PagedResult<UserMembership>
        {
            Items = items,
            TotalCount = totalCount,
            PageNumber = pageNumber,
            PageSize = pageSize
        };
    }

    public async Task ExpireOverdueMembershipsAsync(CancellationToken cancellationToken = default)
    {
        var now = DateTime.UtcNow;
        var overdue = await _dbSet
            .Where(m => m.Status == MembershipStatus.Active && m.EndDate < now)
            .ToListAsync(cancellationToken);

        if (overdue.Count > 0)
        {
            foreach (var m in overdue)
                m.Status = MembershipStatus.Expired;

            await _context.SaveChangesAsync(cancellationToken);
        }
    }

    public async Task<PagedResult<UserMembership>> GetAllMembershipsPagedAsync(
        string? search, MembershipStatus? status, MembershipStatus? excludeStatus, int? userId,
        string? sortBy, bool sortDescending, int pageNumber, int pageSize,
        CancellationToken cancellationToken = default)
    {
        // Auto-expire overdue memberships before querying
        await ExpireOverdueMembershipsAsync(cancellationToken);

        var query = _dbSet
            .Include(m => m.User)
            .Include(m => m.MembershipPlan)
            .AsQueryable();

        if (!string.IsNullOrWhiteSpace(search))
        {
            var searchLower = search.ToLower();
            query = query.Where(m =>
                m.User.FirstName.ToLower().Contains(searchLower) ||
                m.User.LastName.ToLower().Contains(searchLower) ||
                m.User.Email.ToLower().Contains(searchLower) ||
                m.MembershipPlan.Name.ToLower().Contains(searchLower));
        }

        if (status.HasValue)
            query = query.Where(m => m.Status == status.Value);

        if (excludeStatus.HasValue)
            query = query.Where(m => m.Status != excludeStatus.Value);

        if (userId.HasValue)
            query = query.Where(m => m.UserId == userId.Value);

        var totalCount = await query.CountAsync(cancellationToken);

        query = sortBy?.ToLower() switch
        {
            "id" => sortDescending ? query.OrderByDescending(m => m.Id) : query.OrderBy(m => m.Id),
            "userfullname" => sortDescending ? query.OrderByDescending(m => m.User.FirstName) : query.OrderBy(m => m.User.FirstName),
            "planname" => sortDescending ? query.OrderByDescending(m => m.MembershipPlan.Name) : query.OrderBy(m => m.MembershipPlan.Name),
            "planprice" => sortDescending ? query.OrderByDescending(m => m.MembershipPlan.Price) : query.OrderBy(m => m.MembershipPlan.Price),
            "startdate" => sortDescending ? query.OrderByDescending(m => m.StartDate) : query.OrderBy(m => m.StartDate),
            "enddate" => sortDescending ? query.OrderByDescending(m => m.EndDate) : query.OrderBy(m => m.EndDate),
            _ => sortDescending ? query.OrderByDescending(m => m.CreatedAt) : query.OrderBy(m => m.CreatedAt),
        };

        var items = await query
            .Skip((pageNumber - 1) * pageSize)
            .Take(pageSize)
            .ToListAsync(cancellationToken);

        return new PagedResult<UserMembership>
        {
            Items = items,
            TotalCount = totalCount,
            PageNumber = pageNumber,
            PageSize = pageSize
        };
    }
}
