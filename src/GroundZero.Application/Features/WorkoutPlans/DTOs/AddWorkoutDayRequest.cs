namespace GroundZero.Application.Features.WorkoutPlans.DTOs;

public class AddWorkoutDayRequest
{
    public DayOfWeek DayOfWeek { get; set; }
    public string Name { get; set; } = string.Empty;
}
