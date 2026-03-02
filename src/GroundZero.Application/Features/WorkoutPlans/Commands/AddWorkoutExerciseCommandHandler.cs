using GroundZero.Application.Exceptions;
using GroundZero.Application.Features.WorkoutPlans.DTOs;
using GroundZero.Application.IRepositories;
using GroundZero.Application.IServices;
using GroundZero.Domain.Entities;
using MediatR;

namespace GroundZero.Application.Features.WorkoutPlans.Commands;

public class AddWorkoutExerciseCommandHandler : IRequestHandler<AddWorkoutExerciseCommand, WorkoutExerciseResponse>
{
    private readonly IWorkoutPlanRepository _workoutPlanRepository;
    private readonly IExerciseRepository _exerciseRepository;
    private readonly ICurrentUserService _currentUserService;

    public AddWorkoutExerciseCommandHandler(
        IWorkoutPlanRepository workoutPlanRepository,
        IExerciseRepository exerciseRepository,
        ICurrentUserService currentUserService)
    {
        _workoutPlanRepository = workoutPlanRepository;
        _exerciseRepository = exerciseRepository;
        _currentUserService = currentUserService;
    }

    public async Task<WorkoutExerciseResponse> Handle(AddWorkoutExerciseCommand command, CancellationToken cancellationToken)
    {
        var day = await _workoutPlanRepository.GetDayByIdWithPlanAsync(command.DayId, cancellationToken)
            ?? throw new NotFoundException("WorkoutDay", command.DayId);

        if (day.WorkoutPlanId != command.WorkoutPlanId)
            throw new NotFoundException("WorkoutDay", command.DayId);

        if (day.WorkoutPlan.UserId != _currentUserService.UserId!.Value)
            throw new ForbiddenException();

        var exercise = await _exerciseRepository.GetByIdAsync(command.Request.ExerciseId, cancellationToken)
            ?? throw new NotFoundException("Exercise", command.Request.ExerciseId);

        var workoutExercise = new WorkoutExercise
        {
            WorkoutDayId = day.Id,
            ExerciseId = exercise.Id,
            Sets = command.Request.Sets,
            Reps = command.Request.Reps,
            Weight = command.Request.Weight,
            RestSeconds = command.Request.RestSeconds,
            OrderIndex = command.Request.OrderIndex
        };

        await _workoutPlanRepository.AddExerciseAsync(workoutExercise, cancellationToken);
        await _workoutPlanRepository.SaveChangesAsync(cancellationToken);

        workoutExercise.Exercise = exercise;
        return workoutExercise.ToResponse();
    }
}
