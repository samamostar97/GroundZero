using GroundZero.Application.Exceptions;
using GroundZero.Application.Features.WorkoutLogs.DTOs;
using GroundZero.Application.IRepositories;
using GroundZero.Application.IServices;
using GroundZero.Domain.Entities;
using MediatR;

namespace GroundZero.Application.Features.WorkoutLogs.Commands;

public class CreateWorkoutLogCommandHandler : IRequestHandler<CreateWorkoutLogCommand, WorkoutLogResponse>
{
    private readonly IWorkoutLogRepository _workoutLogRepository;
    private readonly IWorkoutPlanRepository _workoutPlanRepository;
    private readonly ICurrentUserService _currentUserService;

    public CreateWorkoutLogCommandHandler(
        IWorkoutLogRepository workoutLogRepository,
        IWorkoutPlanRepository workoutPlanRepository,
        ICurrentUserService currentUserService)
    {
        _workoutLogRepository = workoutLogRepository;
        _workoutPlanRepository = workoutPlanRepository;
        _currentUserService = currentUserService;
    }

    public async Task<WorkoutLogResponse> Handle(CreateWorkoutLogCommand command, CancellationToken cancellationToken)
    {
        var day = await _workoutPlanRepository.GetDayByIdWithPlanAsync(command.Request.WorkoutDayId, cancellationToken)
            ?? throw new NotFoundException("WorkoutDay", command.Request.WorkoutDayId);

        if (day.WorkoutPlan.UserId != _currentUserService.UserId!.Value)
            throw new ForbiddenException();

        var log = new WorkoutLog
        {
            UserId = _currentUserService.UserId!.Value,
            WorkoutDayId = day.Id,
            StartedAt = command.Request.StartedAt,
            CompletedAt = command.Request.CompletedAt,
            Notes = command.Request.Notes
        };

        await _workoutLogRepository.AddAsync(log, cancellationToken);
        await _workoutLogRepository.SaveChangesAsync(cancellationToken);

        log.WorkoutDay = day;
        return log.ToResponse();
    }
}
