namespace GroundZero.Domain.Entities;

public class WorkoutDay : BaseEntity
{
    public int WorkoutPlanId { get; set; }
    public WorkoutPlan WorkoutPlan { get; set; } = null!;
    public DayOfWeek DayOfWeek { get; set; }
    public string Name { get; set; } = string.Empty;
    public ICollection<WorkoutExercise> Exercises { get; set; } = new List<WorkoutExercise>();
}
