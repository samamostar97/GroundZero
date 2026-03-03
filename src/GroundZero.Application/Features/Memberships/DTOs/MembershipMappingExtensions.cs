using GroundZero.Domain.Entities;

namespace GroundZero.Application.Features.Memberships.DTOs;

public static class MembershipMappingExtensions
{
    public static MembershipPlanResponse ToResponse(this MembershipPlan plan)
    {
        return new MembershipPlanResponse
        {
            Id = plan.Id,
            Name = plan.Name,
            Description = plan.Description,
            Price = plan.Price,
            DurationDays = plan.DurationDays,
            IsActive = plan.IsActive,
            CreatedAt = plan.CreatedAt
        };
    }

    public static UserMembershipResponse ToResponse(this UserMembership membership)
    {
        return new UserMembershipResponse
        {
            Id = membership.Id,
            UserId = membership.UserId,
            UserFullName = membership.User != null
                ? $"{membership.User.FirstName} {membership.User.LastName}"
                : string.Empty,
            UserEmail = membership.User?.Email ?? string.Empty,
            PlanName = membership.MembershipPlan?.Name ?? string.Empty,
            PlanPrice = membership.MembershipPlan?.Price ?? 0,
            DurationDays = membership.MembershipPlan?.DurationDays ?? 0,
            StartDate = membership.StartDate,
            EndDate = membership.EndDate,
            Status = membership.Status.ToString(),
            CreatedAt = membership.CreatedAt
        };
    }
}
