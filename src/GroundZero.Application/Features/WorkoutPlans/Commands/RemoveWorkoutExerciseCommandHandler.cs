using GroundZero.Application.Exceptions;
using GroundZero.Application.IRepositories;
using GroundZero.Application.IServices;
using MediatR;

namespace GroundZero.Application.Features.WorkoutPlans.Commands;

public class RemoveWorkoutExerciseCommandHandler : IRequestHandler<RemoveWorkoutExerciseCommand, Unit>
{
    private readonly IWorkoutPlanRepository _workoutPlanRepository;
    private readonly ICurrentUserService _currentUserService;

    public RemoveWorkoutExerciseCommandHandler(
        IWorkoutPlanRepository workoutPlanRepository,
        ICurrentUserService currentUserService)
    {
        _workoutPlanRepository = workoutPlanRepository;
        _currentUserService = currentUserService;
    }

    public async Task<Unit> Handle(RemoveWorkoutExerciseCommand command, CancellationToken cancellationToken)
    {
        var workoutExercise = await _workoutPlanRepository.GetWorkoutExerciseByIdAsync(command.ExerciseId, cancellationToken)
            ?? throw new NotFoundException("WorkoutExercise", command.ExerciseId);

        if (workoutExercise.WorkoutDayId != command.DayId)
            throw new NotFoundException("WorkoutExercise", command.ExerciseId);

        var day = await _workoutPlanRepository.GetDayByIdWithPlanAsync(command.DayId, cancellationToken)
            ?? throw new NotFoundException("WorkoutDay", command.DayId);

        if (day.WorkoutPlanId != command.WorkoutPlanId)
            throw new NotFoundException("WorkoutDay", command.DayId);

        if (day.WorkoutPlan.UserId != _currentUserService.UserId!.Value)
            throw new ForbiddenException();

        _workoutPlanRepository.SoftDeleteExercise(workoutExercise);
        await _workoutPlanRepository.SaveChangesAsync(cancellationToken);

        return Unit.Value;
    }
}
