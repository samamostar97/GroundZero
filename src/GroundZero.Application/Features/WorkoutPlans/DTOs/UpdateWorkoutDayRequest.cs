namespace GroundZero.Application.Features.WorkoutPlans.DTOs;

public class UpdateWorkoutDayRequest
{
    public DayOfWeek DayOfWeek { get; set; }
    public string Name { get; set; } = string.Empty;
}
