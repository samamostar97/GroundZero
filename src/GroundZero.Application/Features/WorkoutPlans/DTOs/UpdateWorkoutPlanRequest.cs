namespace GroundZero.Application.Features.WorkoutPlans.DTOs;

public class UpdateWorkoutPlanRequest
{
    public string Name { get; set; } = string.Empty;
    public string? Description { get; set; }
}
