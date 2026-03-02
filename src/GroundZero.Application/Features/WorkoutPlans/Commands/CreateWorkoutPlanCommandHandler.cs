using GroundZero.Application.Features.WorkoutPlans.DTOs;
using GroundZero.Application.IRepositories;
using GroundZero.Application.IServices;
using GroundZero.Domain.Entities;
using MediatR;

namespace GroundZero.Application.Features.WorkoutPlans.Commands;

public class CreateWorkoutPlanCommandHandler : IRequestHandler<CreateWorkoutPlanCommand, WorkoutPlanResponse>
{
    private readonly IWorkoutPlanRepository _workoutPlanRepository;
    private readonly ICurrentUserService _currentUserService;

    public CreateWorkoutPlanCommandHandler(
        IWorkoutPlanRepository workoutPlanRepository,
        ICurrentUserService currentUserService)
    {
        _workoutPlanRepository = workoutPlanRepository;
        _currentUserService = currentUserService;
    }

    public async Task<WorkoutPlanResponse> Handle(CreateWorkoutPlanCommand command, CancellationToken cancellationToken)
    {
        var plan = new WorkoutPlan
        {
            UserId = _currentUserService.UserId!.Value,
            Name = command.Request.Name,
            Description = command.Request.Description
        };

        await _workoutPlanRepository.AddAsync(plan, cancellationToken);
        await _workoutPlanRepository.SaveChangesAsync(cancellationToken);

        return plan.ToResponse();
    }
}
