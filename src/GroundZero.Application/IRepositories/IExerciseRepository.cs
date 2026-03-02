using GroundZero.Domain.Entities;
using GroundZero.Domain.Enums;

namespace GroundZero.Application.IRepositories;

public interface IExerciseRepository : IRepository<Exercise>
{
    Task<List<Exercise>> GetAllAsync(MuscleGroup? muscleGroup, CancellationToken cancellationToken = default);
}
