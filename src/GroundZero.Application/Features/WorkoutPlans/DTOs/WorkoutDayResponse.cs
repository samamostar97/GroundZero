namespace GroundZero.Application.Features.WorkoutPlans.DTOs;

public class WorkoutDayResponse
{
    public int Id { get; set; }
    public DayOfWeek DayOfWeek { get; set; }
    public string Name { get; set; } = string.Empty;
    public List<WorkoutExerciseResponse> Exercises { get; set; } = new();
}
