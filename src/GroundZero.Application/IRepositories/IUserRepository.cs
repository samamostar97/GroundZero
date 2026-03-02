using GroundZero.Application.Common;
using GroundZero.Domain.Entities;

namespace GroundZero.Application.IRepositories;

public interface IUserRepository : IRepository<User>
{
    Task<User?> GetByEmailAsync(string email, CancellationToken cancellationToken = default);
    Task<bool> EmailExistsAsync(string email, CancellationToken cancellationToken = default);
    Task<PagedResult<User>> GetPagedAsync(string? search, int pageNumber, int pageSize, CancellationToken cancellationToken = default);
}
