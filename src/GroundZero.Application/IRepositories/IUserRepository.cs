using GroundZero.Application.Common;
using GroundZero.Domain.Entities;

namespace GroundZero.Application.IRepositories;

public interface IUserRepository : IRepository<User>
{
    Task<User?> GetByEmailAsync(string email, CancellationToken cancellationToken = default);
    Task<bool> EmailExistsAsync(string email, CancellationToken cancellationToken = default);
    Task<PagedResult<User>> GetPagedAsync(string? search, string? sortBy, bool sortDescending, int pageNumber, int pageSize, CancellationToken cancellationToken = default);
    Task<PagedResult<User>> GetLeaderboardPagedAsync(int pageNumber, int pageSize, CancellationToken cancellationToken = default);
    Task<int> GetUserRankAsync(int userId, CancellationToken cancellationToken = default);
}
