using GroundZero.Application.Common;
using GroundZero.Domain.Entities;

namespace GroundZero.Application.IRepositories;

public interface IProductRepository : IRepository<Product>
{
    Task<Product?> GetByIdWithCategoryAsync(int id, CancellationToken cancellationToken = default);
    Task<PagedResult<Product>> GetPagedAsync(string? search, int? categoryId, decimal? minPrice, decimal? maxPrice, string? sortBy, bool sortDescending, int pageNumber, int pageSize, CancellationToken cancellationToken = default);
}
