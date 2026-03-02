using GroundZero.Application.Exceptions;
using GroundZero.Application.IRepositories;
using GroundZero.Application.IServices;
using MediatR;

namespace GroundZero.Application.Features.WorkoutPlans.Commands;

public class RemoveWorkoutDayCommandHandler : IRequestHandler<RemoveWorkoutDayCommand, Unit>
{
    private readonly IWorkoutPlanRepository _workoutPlanRepository;
    private readonly ICurrentUserService _currentUserService;

    public RemoveWorkoutDayCommandHandler(
        IWorkoutPlanRepository workoutPlanRepository,
        ICurrentUserService currentUserService)
    {
        _workoutPlanRepository = workoutPlanRepository;
        _currentUserService = currentUserService;
    }

    public async Task<Unit> Handle(RemoveWorkoutDayCommand command, CancellationToken cancellationToken)
    {
        var day = await _workoutPlanRepository.GetDayByIdWithPlanAsync(command.DayId, cancellationToken)
            ?? throw new NotFoundException("WorkoutDay", command.DayId);

        if (day.WorkoutPlanId != command.WorkoutPlanId)
            throw new NotFoundException("WorkoutDay", command.DayId);

        if (day.WorkoutPlan.UserId != _currentUserService.UserId!.Value)
            throw new ForbiddenException();

        _workoutPlanRepository.SoftDeleteDay(day);
        await _workoutPlanRepository.SaveChangesAsync(cancellationToken);

        return Unit.Value;
    }
}
