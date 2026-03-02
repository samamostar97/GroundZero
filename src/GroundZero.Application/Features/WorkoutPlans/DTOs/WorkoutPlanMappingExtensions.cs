using GroundZero.Domain.Entities;

namespace GroundZero.Application.Features.WorkoutPlans.DTOs;

public static class WorkoutPlanMappingExtensions
{
    public static WorkoutPlanResponse ToResponse(this WorkoutPlan plan)
    {
        return new WorkoutPlanResponse
        {
            Id = plan.Id,
            Name = plan.Name,
            Description = plan.Description,
            Days = plan.Days
                .Where(d => !d.IsDeleted)
                .OrderBy(d => d.DayOfWeek)
                .Select(d => d.ToResponse())
                .ToList(),
            CreatedAt = plan.CreatedAt
        };
    }

    public static WorkoutDayResponse ToResponse(this WorkoutDay day)
    {
        return new WorkoutDayResponse
        {
            Id = day.Id,
            DayOfWeek = day.DayOfWeek,
            Name = day.Name,
            Exercises = day.Exercises
                .Where(e => !e.IsDeleted)
                .OrderBy(e => e.OrderIndex)
                .Select(e => e.ToResponse())
                .ToList()
        };
    }

    public static WorkoutExerciseResponse ToResponse(this WorkoutExercise exercise)
    {
        return new WorkoutExerciseResponse
        {
            Id = exercise.Id,
            ExerciseId = exercise.ExerciseId,
            ExerciseName = exercise.Exercise?.Name ?? string.Empty,
            MuscleGroup = exercise.Exercise?.MuscleGroup ?? 0,
            Sets = exercise.Sets,
            Reps = exercise.Reps,
            Weight = exercise.Weight,
            RestSeconds = exercise.RestSeconds,
            OrderIndex = exercise.OrderIndex
        };
    }
}
