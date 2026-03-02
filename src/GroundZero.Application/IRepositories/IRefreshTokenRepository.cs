using GroundZero.Domain.Entities;

namespace GroundZero.Application.IRepositories;

public interface IRefreshTokenRepository : IRepository<RefreshToken>
{
    Task<RefreshToken?> GetByTokenAsync(string token, CancellationToken cancellationToken = default);
    Task RevokeAllForUserAsync(int userId, CancellationToken cancellationToken = default);
}
