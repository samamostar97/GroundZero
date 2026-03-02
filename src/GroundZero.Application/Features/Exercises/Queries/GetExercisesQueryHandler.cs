using GroundZero.Application.Features.Exercises.DTOs;
using GroundZero.Application.IRepositories;
using MediatR;

namespace GroundZero.Application.Features.Exercises.Queries;

public class GetExercisesQueryHandler : IRequestHandler<GetExercisesQuery, List<ExerciseResponse>>
{
    private readonly IExerciseRepository _exerciseRepository;

    public GetExercisesQueryHandler(IExerciseRepository exerciseRepository)
    {
        _exerciseRepository = exerciseRepository;
    }

    public async Task<List<ExerciseResponse>> Handle(GetExercisesQuery request, CancellationToken cancellationToken)
    {
        var exercises = await _exerciseRepository.GetAllAsync(request.MuscleGroup, cancellationToken);
        return exercises.Select(e => e.ToResponse()).ToList();
    }
}
