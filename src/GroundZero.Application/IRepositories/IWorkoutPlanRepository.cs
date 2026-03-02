using GroundZero.Application.Common;
using GroundZero.Domain.Entities;

namespace GroundZero.Application.IRepositories;

public interface IWorkoutPlanRepository : IRepository<WorkoutPlan>
{
    Task<WorkoutPlan?> GetByIdWithDetailsAsync(int id, CancellationToken cancellationToken = default);
    Task<PagedResult<WorkoutPlan>> GetUserPlansPagedAsync(int userId, string? search, int pageNumber, int pageSize, CancellationToken cancellationToken = default);
    Task<WorkoutDay?> GetDayByIdAsync(int dayId, CancellationToken cancellationToken = default);
    Task<WorkoutDay?> GetDayByIdWithPlanAsync(int dayId, CancellationToken cancellationToken = default);
    Task<WorkoutExercise?> GetWorkoutExerciseByIdAsync(int id, CancellationToken cancellationToken = default);
    Task<WorkoutDay> AddDayAsync(WorkoutDay day, CancellationToken cancellationToken = default);
    Task<WorkoutExercise> AddExerciseAsync(WorkoutExercise exercise, CancellationToken cancellationToken = default);
    void UpdateDay(WorkoutDay day);
    void UpdateExercise(WorkoutExercise exercise);
    void SoftDeleteDay(WorkoutDay day);
    void SoftDeleteExercise(WorkoutExercise exercise);
}
