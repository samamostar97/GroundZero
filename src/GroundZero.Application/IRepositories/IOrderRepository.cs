using GroundZero.Application.Common;
using GroundZero.Domain.Entities;
using GroundZero.Domain.Enums;

namespace GroundZero.Application.IRepositories;

public interface IOrderRepository : IRepository<Order>
{
    Task<Order?> GetByIdWithItemsAsync(int id, CancellationToken cancellationToken = default);
    Task<PagedResult<Order>> GetUserOrdersPagedAsync(int userId, OrderStatus? status, int pageNumber, int pageSize, CancellationToken cancellationToken = default);
    Task<PagedResult<Order>> GetAllOrdersPagedAsync(string? search, OrderStatus? status, int? userId, string? sortBy, bool sortDescending, int pageNumber, int pageSize, string? excludeStatuses = null, CancellationToken cancellationToken = default);
}
