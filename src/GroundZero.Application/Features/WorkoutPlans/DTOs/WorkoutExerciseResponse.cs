using GroundZero.Domain.Enums;

namespace GroundZero.Application.Features.WorkoutPlans.DTOs;

public class WorkoutExerciseResponse
{
    public int Id { get; set; }
    public int ExerciseId { get; set; }
    public string ExerciseName { get; set; } = string.Empty;
    public MuscleGroup MuscleGroup { get; set; }
    public int Sets { get; set; }
    public int Reps { get; set; }
    public decimal? Weight { get; set; }
    public int? RestSeconds { get; set; }
    public int OrderIndex { get; set; }
}
