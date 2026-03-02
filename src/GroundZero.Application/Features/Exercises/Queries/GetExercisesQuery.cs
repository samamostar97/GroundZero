using GroundZero.Application.Features.Exercises.DTOs;
using GroundZero.Domain.Enums;
using MediatR;

namespace GroundZero.Application.Features.Exercises.Queries;

public class GetExercisesQuery : IRequest<List<ExerciseResponse>>
{
    public MuscleGroup? MuscleGroup { get; set; }
}
