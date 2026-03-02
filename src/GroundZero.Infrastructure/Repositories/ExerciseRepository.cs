using GroundZero.Application.IRepositories;
using GroundZero.Domain.Entities;
using GroundZero.Domain.Enums;
using GroundZero.Infrastructure.Data;
using Microsoft.EntityFrameworkCore;

namespace GroundZero.Infrastructure.Repositories;

public class ExerciseRepository : Repository<Exercise>, IExerciseRepository
{
    public ExerciseRepository(ApplicationDbContext context) : base(context) { }

    public async Task<List<Exercise>> GetAllAsync(MuscleGroup? muscleGroup, CancellationToken cancellationToken = default)
    {
        var query = _dbSet.AsQueryable();

        if (muscleGroup.HasValue)
            query = query.Where(e => e.MuscleGroup == muscleGroup.Value);

        return await query
            .OrderBy(e => e.MuscleGroup)
            .ThenBy(e => e.Name)
            .ToListAsync(cancellationToken);
    }
}
