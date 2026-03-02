using GroundZero.Application.Exceptions;
using GroundZero.Application.Features.WorkoutPlans.DTOs;
using GroundZero.Application.IRepositories;
using GroundZero.Application.IServices;
using MediatR;

namespace GroundZero.Application.Features.WorkoutPlans.Commands;

public class UpdateWorkoutPlanCommandHandler : IRequestHandler<UpdateWorkoutPlanCommand, WorkoutPlanResponse>
{
    private readonly IWorkoutPlanRepository _workoutPlanRepository;
    private readonly ICurrentUserService _currentUserService;

    public UpdateWorkoutPlanCommandHandler(
        IWorkoutPlanRepository workoutPlanRepository,
        ICurrentUserService currentUserService)
    {
        _workoutPlanRepository = workoutPlanRepository;
        _currentUserService = currentUserService;
    }

    public async Task<WorkoutPlanResponse> Handle(UpdateWorkoutPlanCommand command, CancellationToken cancellationToken)
    {
        var plan = await _workoutPlanRepository.GetByIdWithDetailsAsync(command.Id, cancellationToken)
            ?? throw new NotFoundException("WorkoutPlan", command.Id);

        if (plan.UserId != _currentUserService.UserId!.Value)
            throw new ForbiddenException();

        plan.Name = command.Request.Name;
        plan.Description = command.Request.Description;

        _workoutPlanRepository.Update(plan);
        await _workoutPlanRepository.SaveChangesAsync(cancellationToken);

        return plan.ToResponse();
    }
}
