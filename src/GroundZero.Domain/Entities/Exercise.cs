using GroundZero.Domain.Enums;

namespace GroundZero.Domain.Entities;

public class Exercise : BaseEntity
{
    public string Name { get; set; } = string.Empty;
    public MuscleGroup MuscleGroup { get; set; }
    public string? Description { get; set; }
}
