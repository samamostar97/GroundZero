using GroundZero.Domain.Entities;

namespace GroundZero.Application.Features.GymVisits.DTOs;

public static class GymVisitMappingExtensions
{
    public static GymVisitResponse ToResponse(this GymVisit gymVisit, int xpEarned = 0)
    {
        return new GymVisitResponse
        {
            Id = gymVisit.Id,
            UserId = gymVisit.UserId,
            UserFullName = gymVisit.User != null
                ? $"{gymVisit.User.FirstName} {gymVisit.User.LastName}"
                : string.Empty,
            CheckInAt = gymVisit.CheckInAt,
            CheckOutAt = gymVisit.CheckOutAt,
            DurationMinutes = gymVisit.DurationMinutes,
            XpEarned = xpEarned,
            CreatedAt = gymVisit.CreatedAt
        };
    }
}
