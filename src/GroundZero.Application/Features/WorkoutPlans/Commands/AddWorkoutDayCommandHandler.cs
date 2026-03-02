using GroundZero.Application.Exceptions;
using GroundZero.Application.Features.WorkoutPlans.DTOs;
using GroundZero.Application.IRepositories;
using GroundZero.Application.IServices;
using GroundZero.Domain.Entities;
using MediatR;

namespace GroundZero.Application.Features.WorkoutPlans.Commands;

public class AddWorkoutDayCommandHandler : IRequestHandler<AddWorkoutDayCommand, WorkoutDayResponse>
{
    private readonly IWorkoutPlanRepository _workoutPlanRepository;
    private readonly ICurrentUserService _currentUserService;

    public AddWorkoutDayCommandHandler(
        IWorkoutPlanRepository workoutPlanRepository,
        ICurrentUserService currentUserService)
    {
        _workoutPlanRepository = workoutPlanRepository;
        _currentUserService = currentUserService;
    }

    public async Task<WorkoutDayResponse> Handle(AddWorkoutDayCommand command, CancellationToken cancellationToken)
    {
        var plan = await _workoutPlanRepository.GetByIdAsync(command.WorkoutPlanId, cancellationToken)
            ?? throw new NotFoundException("WorkoutPlan", command.WorkoutPlanId);

        if (plan.UserId != _currentUserService.UserId!.Value)
            throw new ForbiddenException();

        var day = new WorkoutDay
        {
            WorkoutPlanId = plan.Id,
            DayOfWeek = command.Request.DayOfWeek,
            Name = command.Request.Name
        };

        await _workoutPlanRepository.AddDayAsync(day, cancellationToken);
        await _workoutPlanRepository.SaveChangesAsync(cancellationToken);

        return day.ToResponse();
    }
}
