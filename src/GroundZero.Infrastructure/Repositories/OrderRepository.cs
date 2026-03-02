using GroundZero.Application.Common;
using GroundZero.Application.IRepositories;
using GroundZero.Domain.Entities;
using GroundZero.Domain.Enums;
using GroundZero.Infrastructure.Data;
using Microsoft.EntityFrameworkCore;

namespace GroundZero.Infrastructure.Repositories;

public class OrderRepository : Repository<Order>, IOrderRepository
{
    public OrderRepository(ApplicationDbContext context) : base(context) { }

    public async Task<Order?> GetByIdWithItemsAsync(int id, CancellationToken cancellationToken = default)
    {
        return await _dbSet
            .Include(o => o.User)
            .Include(o => o.Items)
                .ThenInclude(i => i.Product)
            .FirstOrDefaultAsync(o => o.Id == id, cancellationToken);
    }

    public async Task<PagedResult<Order>> GetUserOrdersPagedAsync(
        int userId, OrderStatus? status, int pageNumber, int pageSize,
        CancellationToken cancellationToken = default)
    {
        var query = _dbSet
            .Include(o => o.User)
            .Include(o => o.Items)
                .ThenInclude(i => i.Product)
            .Where(o => o.UserId == userId);

        if (status.HasValue)
            query = query.Where(o => o.Status == status.Value);

        var totalCount = await query.CountAsync(cancellationToken);

        var items = await query
            .OrderByDescending(o => o.CreatedAt)
            .Skip((pageNumber - 1) * pageSize)
            .Take(pageSize)
            .ToListAsync(cancellationToken);

        return new PagedResult<Order>
        {
            Items = items,
            TotalCount = totalCount,
            PageNumber = pageNumber,
            PageSize = pageSize
        };
    }

    public async Task<PagedResult<Order>> GetAllOrdersPagedAsync(
        string? search, OrderStatus? status, int? userId, int pageNumber, int pageSize,
        CancellationToken cancellationToken = default)
    {
        var query = _dbSet
            .Include(o => o.User)
            .Include(o => o.Items)
                .ThenInclude(i => i.Product)
            .AsQueryable();

        if (!string.IsNullOrWhiteSpace(search))
        {
            var searchLower = search.ToLower();
            query = query.Where(o =>
                o.User.FirstName.ToLower().Contains(searchLower) ||
                o.User.LastName.ToLower().Contains(searchLower) ||
                o.User.Email.ToLower().Contains(searchLower));
        }

        if (status.HasValue)
            query = query.Where(o => o.Status == status.Value);

        if (userId.HasValue)
            query = query.Where(o => o.UserId == userId.Value);

        var totalCount = await query.CountAsync(cancellationToken);

        var items = await query
            .OrderByDescending(o => o.CreatedAt)
            .Skip((pageNumber - 1) * pageSize)
            .Take(pageSize)
            .ToListAsync(cancellationToken);

        return new PagedResult<Order>
        {
            Items = items,
            TotalCount = totalCount,
            PageNumber = pageNumber,
            PageSize = pageSize
        };
    }
}
