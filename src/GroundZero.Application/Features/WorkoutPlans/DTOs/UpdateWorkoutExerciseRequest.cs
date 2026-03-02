namespace GroundZero.Application.Features.WorkoutPlans.DTOs;

public class UpdateWorkoutExerciseRequest
{
    public int Sets { get; set; }
    public int Reps { get; set; }
    public decimal? Weight { get; set; }
    public int? RestSeconds { get; set; }
    public int OrderIndex { get; set; }
}
