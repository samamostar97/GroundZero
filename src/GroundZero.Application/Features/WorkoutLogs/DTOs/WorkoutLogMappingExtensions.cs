using GroundZero.Domain.Entities;

namespace GroundZero.Application.Features.WorkoutLogs.DTOs;

public static class WorkoutLogMappingExtensions
{
    public static WorkoutLogResponse ToResponse(this WorkoutLog log)
    {
        return new WorkoutLogResponse
        {
            Id = log.Id,
            WorkoutDayId = log.WorkoutDayId,
            WorkoutDayName = log.WorkoutDay?.Name ?? string.Empty,
            WorkoutPlanName = log.WorkoutDay?.WorkoutPlan?.Name ?? string.Empty,
            StartedAt = log.StartedAt,
            CompletedAt = log.CompletedAt,
            Notes = log.Notes,
            CreatedAt = log.CreatedAt
        };
    }
}
