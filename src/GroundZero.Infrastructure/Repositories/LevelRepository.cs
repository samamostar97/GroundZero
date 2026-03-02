using GroundZero.Application.IRepositories;
using GroundZero.Domain.Entities;
using GroundZero.Infrastructure.Data;
using Microsoft.EntityFrameworkCore;

namespace GroundZero.Infrastructure.Repositories;

public class LevelRepository : Repository<Level>, ILevelRepository
{
    public LevelRepository(ApplicationDbContext context) : base(context) { }

    public async Task<List<Level>> GetAllOrderedAsync(CancellationToken cancellationToken = default)
    {
        return await _dbSet
            .OrderBy(l => l.MinXP)
            .ToListAsync(cancellationToken);
    }

    public async Task<Level?> GetLevelByXpAsync(int xp, CancellationToken cancellationToken = default)
    {
        return await _dbSet
            .Where(l => xp >= l.MinXP)
            .OrderByDescending(l => l.MinXP)
            .FirstOrDefaultAsync(cancellationToken);
    }
}
