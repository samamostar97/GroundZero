using GroundZero.Application.Exceptions;
using GroundZero.Application.Features.WorkoutPlans.DTOs;
using GroundZero.Application.IRepositories;
using GroundZero.Application.IServices;
using MediatR;

namespace GroundZero.Application.Features.WorkoutPlans.Queries;

public class GetWorkoutPlanByIdQueryHandler : IRequestHandler<GetWorkoutPlanByIdQuery, WorkoutPlanResponse>
{
    private readonly IWorkoutPlanRepository _workoutPlanRepository;
    private readonly ICurrentUserService _currentUserService;

    public GetWorkoutPlanByIdQueryHandler(
        IWorkoutPlanRepository workoutPlanRepository,
        ICurrentUserService currentUserService)
    {
        _workoutPlanRepository = workoutPlanRepository;
        _currentUserService = currentUserService;
    }

    public async Task<WorkoutPlanResponse> Handle(GetWorkoutPlanByIdQuery request, CancellationToken cancellationToken)
    {
        var plan = await _workoutPlanRepository.GetByIdWithDetailsAsync(request.Id, cancellationToken)
            ?? throw new NotFoundException("WorkoutPlan", request.Id);

        if (plan.UserId != _currentUserService.UserId!.Value)
            throw new ForbiddenException();

        return plan.ToResponse();
    }
}
