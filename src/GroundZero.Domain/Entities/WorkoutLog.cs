namespace GroundZero.Domain.Entities;

public class WorkoutLog : BaseEntity
{
    public int UserId { get; set; }
    public User User { get; set; } = null!;
    public int WorkoutDayId { get; set; }
    public WorkoutDay WorkoutDay { get; set; } = null!;
    public DateTime StartedAt { get; set; }
    public DateTime? CompletedAt { get; set; }
    public string? Notes { get; set; }
}
