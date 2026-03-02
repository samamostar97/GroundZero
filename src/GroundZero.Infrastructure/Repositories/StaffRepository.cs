using GroundZero.Application.Common;
using GroundZero.Application.IRepositories;
using GroundZero.Domain.Entities;
using GroundZero.Domain.Enums;
using GroundZero.Infrastructure.Data;
using Microsoft.EntityFrameworkCore;

namespace GroundZero.Infrastructure.Repositories;

public class StaffRepository : Repository<Staff>, IStaffRepository
{
    public StaffRepository(ApplicationDbContext context) : base(context) { }

    public async Task<bool> EmailExistsAsync(string email, int? excludeId = null, CancellationToken cancellationToken = default)
    {
        var query = _dbSet.Where(s => s.Email == email.ToLower());

        if (excludeId.HasValue)
            query = query.Where(s => s.Id != excludeId.Value);

        return await query.AnyAsync(cancellationToken);
    }

    public async Task<PagedResult<Staff>> GetPagedAsync(string? search, StaffType? staffType, int pageNumber, int pageSize, CancellationToken cancellationToken = default)
    {
        var query = _dbSet.AsQueryable();

        if (!string.IsNullOrWhiteSpace(search))
        {
            var searchLower = search.ToLower();
            query = query.Where(s =>
                s.FirstName.ToLower().Contains(searchLower) ||
                s.LastName.ToLower().Contains(searchLower) ||
                s.Email.ToLower().Contains(searchLower));
        }

        if (staffType.HasValue)
            query = query.Where(s => s.StaffType == staffType.Value);

        var totalCount = await query.CountAsync(cancellationToken);

        var items = await query
            .OrderByDescending(s => s.CreatedAt)
            .Skip((pageNumber - 1) * pageSize)
            .Take(pageSize)
            .ToListAsync(cancellationToken);

        return new PagedResult<Staff>
        {
            Items = items,
            TotalCount = totalCount,
            PageNumber = pageNumber,
            PageSize = pageSize
        };
    }
}
