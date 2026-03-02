using GroundZero.Domain.Enums;

namespace GroundZero.Application.Features.Exercises.DTOs;

public class ExerciseResponse
{
    public int Id { get; set; }
    public string Name { get; set; } = string.Empty;
    public MuscleGroup MuscleGroup { get; set; }
    public string? Description { get; set; }
}
