using GroundZero.Application.Exceptions;
using GroundZero.Application.IRepositories;
using GroundZero.Application.IServices;
using MediatR;

namespace GroundZero.Application.Features.WorkoutPlans.Commands;

public class DeleteWorkoutPlanCommandHandler : IRequestHandler<DeleteWorkoutPlanCommand, Unit>
{
    private readonly IWorkoutPlanRepository _workoutPlanRepository;
    private readonly ICurrentUserService _currentUserService;

    public DeleteWorkoutPlanCommandHandler(
        IWorkoutPlanRepository workoutPlanRepository,
        ICurrentUserService currentUserService)
    {
        _workoutPlanRepository = workoutPlanRepository;
        _currentUserService = currentUserService;
    }

    public async Task<Unit> Handle(DeleteWorkoutPlanCommand command, CancellationToken cancellationToken)
    {
        var plan = await _workoutPlanRepository.GetByIdAsync(command.Id, cancellationToken)
            ?? throw new NotFoundException("WorkoutPlan", command.Id);

        if (plan.UserId != _currentUserService.UserId!.Value)
            throw new ForbiddenException();

        _workoutPlanRepository.SoftDelete(plan);
        await _workoutPlanRepository.SaveChangesAsync(cancellationToken);

        return Unit.Value;
    }
}
