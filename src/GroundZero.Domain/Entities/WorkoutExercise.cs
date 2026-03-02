namespace GroundZero.Domain.Entities;

public class WorkoutExercise : BaseEntity
{
    public int WorkoutDayId { get; set; }
    public WorkoutDay WorkoutDay { get; set; } = null!;
    public int ExerciseId { get; set; }
    public Exercise Exercise { get; set; } = null!;
    public int Sets { get; set; }
    public int Reps { get; set; }
    public decimal? Weight { get; set; }
    public int? RestSeconds { get; set; }
    public int OrderIndex { get; set; }
}
