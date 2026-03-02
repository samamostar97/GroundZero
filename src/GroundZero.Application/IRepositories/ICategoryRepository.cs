using GroundZero.Domain.Entities;

namespace GroundZero.Application.IRepositories;

public interface ICategoryRepository : IRepository<ProductCategory>
{
    Task<bool> NameExistsAsync(string name, int? excludeId = null, CancellationToken cancellationToken = default);
    Task<bool> HasProductsAsync(int categoryId, CancellationToken cancellationToken = default);
}
