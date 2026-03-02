namespace GroundZero.Application.Features.WorkoutPlans.DTOs;

public class WorkoutPlanResponse
{
    public int Id { get; set; }
    public string Name { get; set; } = string.Empty;
    public string? Description { get; set; }
    public List<WorkoutDayResponse> Days { get; set; } = new();
    public DateTime CreatedAt { get; set; }
}
