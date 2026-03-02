namespace GroundZero.Application.Features.WorkoutLogs.DTOs;

public class CreateWorkoutLogRequest
{
    public int WorkoutDayId { get; set; }
    public DateTime StartedAt { get; set; }
    public DateTime? CompletedAt { get; set; }
    public string? Notes { get; set; }
}
