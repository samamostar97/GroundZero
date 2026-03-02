using GroundZero.Application.Exceptions;
using GroundZero.Application.Features.WorkoutLogs.DTOs;
using GroundZero.Application.IRepositories;
using GroundZero.Application.IServices;
using MediatR;

namespace GroundZero.Application.Features.WorkoutLogs.Queries;

public class GetWorkoutLogByIdQueryHandler : IRequestHandler<GetWorkoutLogByIdQuery, WorkoutLogResponse>
{
    private readonly IWorkoutLogRepository _workoutLogRepository;
    private readonly ICurrentUserService _currentUserService;

    public GetWorkoutLogByIdQueryHandler(
        IWorkoutLogRepository workoutLogRepository,
        ICurrentUserService currentUserService)
    {
        _workoutLogRepository = workoutLogRepository;
        _currentUserService = currentUserService;
    }

    public async Task<WorkoutLogResponse> Handle(GetWorkoutLogByIdQuery request, CancellationToken cancellationToken)
    {
        var log = await _workoutLogRepository.GetByIdWithDetailsAsync(request.Id, cancellationToken)
            ?? throw new NotFoundException("WorkoutLog", request.Id);

        if (log.UserId != _currentUserService.UserId!.Value)
            throw new ForbiddenException();

        return log.ToResponse();
    }
}
