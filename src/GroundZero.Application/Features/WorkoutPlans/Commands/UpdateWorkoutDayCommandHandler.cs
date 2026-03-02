using GroundZero.Application.Exceptions;
using GroundZero.Application.Features.WorkoutPlans.DTOs;
using GroundZero.Application.IRepositories;
using GroundZero.Application.IServices;
using MediatR;

namespace GroundZero.Application.Features.WorkoutPlans.Commands;

public class UpdateWorkoutDayCommandHandler : IRequestHandler<UpdateWorkoutDayCommand, WorkoutDayResponse>
{
    private readonly IWorkoutPlanRepository _workoutPlanRepository;
    private readonly ICurrentUserService _currentUserService;

    public UpdateWorkoutDayCommandHandler(
        IWorkoutPlanRepository workoutPlanRepository,
        ICurrentUserService currentUserService)
    {
        _workoutPlanRepository = workoutPlanRepository;
        _currentUserService = currentUserService;
    }

    public async Task<WorkoutDayResponse> Handle(UpdateWorkoutDayCommand command, CancellationToken cancellationToken)
    {
        var day = await _workoutPlanRepository.GetDayByIdWithPlanAsync(command.DayId, cancellationToken)
            ?? throw new NotFoundException("WorkoutDay", command.DayId);

        if (day.WorkoutPlanId != command.WorkoutPlanId)
            throw new NotFoundException("WorkoutDay", command.DayId);

        if (day.WorkoutPlan.UserId != _currentUserService.UserId!.Value)
            throw new ForbiddenException();

        day.DayOfWeek = command.Request.DayOfWeek;
        day.Name = command.Request.Name;

        _workoutPlanRepository.UpdateDay(day);
        await _workoutPlanRepository.SaveChangesAsync(cancellationToken);

        return day.ToResponse();
    }
}
