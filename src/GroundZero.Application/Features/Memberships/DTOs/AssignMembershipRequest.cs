namespace GroundZero.Application.Features.Memberships.DTOs;

public class AssignMembershipRequest
{
    public int UserId { get; set; }
    public int MembershipPlanId { get; set; }
    public DateTime StartDate { get; set; }
}
