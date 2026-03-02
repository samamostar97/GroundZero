using GroundZero.Application.Common;
using GroundZero.Application.Features.WorkoutPlans.DTOs;
using GroundZero.Application.IRepositories;
using GroundZero.Application.IServices;
using MediatR;

namespace GroundZero.Application.Features.WorkoutPlans.Queries;

public class GetUserWorkoutPlansQueryHandler : IRequestHandler<GetUserWorkoutPlansQuery, PagedResult<WorkoutPlanResponse>>
{
    private readonly IWorkoutPlanRepository _workoutPlanRepository;
    private readonly ICurrentUserService _currentUserService;

    public GetUserWorkoutPlansQueryHandler(
        IWorkoutPlanRepository workoutPlanRepository,
        ICurrentUserService currentUserService)
    {
        _workoutPlanRepository = workoutPlanRepository;
        _currentUserService = currentUserService;
    }

    public async Task<PagedResult<WorkoutPlanResponse>> Handle(GetUserWorkoutPlansQuery request, CancellationToken cancellationToken)
    {
        var result = await _workoutPlanRepository.GetUserPlansPagedAsync(
            _currentUserService.UserId!.Value,
            request.Search,
            request.PageNumber,
            request.PageSize,
            cancellationToken);

        return new PagedResult<WorkoutPlanResponse>
        {
            Items = result.Items.Select(p => p.ToResponse()).ToList(),
            TotalCount = result.TotalCount,
            PageNumber = result.PageNumber,
            PageSize = result.PageSize
        };
    }
}
