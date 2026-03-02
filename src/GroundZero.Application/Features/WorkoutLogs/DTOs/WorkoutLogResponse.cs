namespace GroundZero.Application.Features.WorkoutLogs.DTOs;

public class WorkoutLogResponse
{
    public int Id { get; set; }
    public int WorkoutDayId { get; set; }
    public string WorkoutDayName { get; set; } = string.Empty;
    public string WorkoutPlanName { get; set; } = string.Empty;
    public DateTime StartedAt { get; set; }
    public DateTime? CompletedAt { get; set; }
    public string? Notes { get; set; }
    public DateTime CreatedAt { get; set; }
}
