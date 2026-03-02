namespace GroundZero.Domain.Entities;

public class WorkoutPlan : BaseEntity
{
    public int UserId { get; set; }
    public User User { get; set; } = null!;
    public string Name { get; set; } = string.Empty;
    public string? Description { get; set; }
    public ICollection<WorkoutDay> Days { get; set; } = new List<WorkoutDay>();
}
