namespace GroundZero.Application.Features.WorkoutPlans.DTOs;

public class AddWorkoutExerciseRequest
{
    public int ExerciseId { get; set; }
    public int Sets { get; set; }
    public int Reps { get; set; }
    public decimal? Weight { get; set; }
    public int? RestSeconds { get; set; }
    public int OrderIndex { get; set; }
}
