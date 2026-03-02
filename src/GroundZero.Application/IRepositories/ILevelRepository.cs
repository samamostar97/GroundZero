using GroundZero.Domain.Entities;

namespace GroundZero.Application.IRepositories;

public interface ILevelRepository : IRepository<Level>
{
    Task<List<Level>> GetAllOrderedAsync(CancellationToken cancellationToken = default);
    Task<Level?> GetLevelByXpAsync(int xp, CancellationToken cancellationToken = default);
}
