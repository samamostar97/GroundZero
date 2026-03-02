using GroundZero.Application.Common;
using GroundZero.Application.Features.WorkoutLogs.DTOs;
using GroundZero.Application.IRepositories;
using GroundZero.Application.IServices;
using MediatR;

namespace GroundZero.Application.Features.WorkoutLogs.Queries;

public class GetUserWorkoutLogsQueryHandler : IRequestHandler<GetUserWorkoutLogsQuery, PagedResult<WorkoutLogResponse>>
{
    private readonly IWorkoutLogRepository _workoutLogRepository;
    private readonly ICurrentUserService _currentUserService;

    public GetUserWorkoutLogsQueryHandler(
        IWorkoutLogRepository workoutLogRepository,
        ICurrentUserService currentUserService)
    {
        _workoutLogRepository = workoutLogRepository;
        _currentUserService = currentUserService;
    }

    public async Task<PagedResult<WorkoutLogResponse>> Handle(GetUserWorkoutLogsQuery request, CancellationToken cancellationToken)
    {
        var result = await _workoutLogRepository.GetUserLogsPagedAsync(
            _currentUserService.UserId!.Value,
            request.PageNumber,
            request.PageSize,
            cancellationToken);

        return new PagedResult<WorkoutLogResponse>
        {
            Items = result.Items.Select(l => l.ToResponse()).ToList(),
            TotalCount = result.TotalCount,
            PageNumber = result.PageNumber,
            PageSize = result.PageSize
        };
    }
}
