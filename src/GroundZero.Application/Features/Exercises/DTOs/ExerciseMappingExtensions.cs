using GroundZero.Domain.Entities;

namespace GroundZero.Application.Features.Exercises.DTOs;

public static class ExerciseMappingExtensions
{
    public static ExerciseResponse ToResponse(this Exercise exercise)
    {
        return new ExerciseResponse
        {
            Id = exercise.Id,
            Name = exercise.Name,
            MuscleGroup = exercise.MuscleGroup,
            Description = exercise.Description
        };
    }
}
