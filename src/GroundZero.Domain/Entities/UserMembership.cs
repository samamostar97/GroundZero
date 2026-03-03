using GroundZero.Domain.Enums;

namespace GroundZero.Domain.Entities;

public class UserMembership : BaseEntity
{
    public int UserId { get; set; }
    public User User { get; set; } = null!;
    public int MembershipPlanId { get; set; }
    public MembershipPlan MembershipPlan { get; set; } = null!;
    public DateTime StartDate { get; set; }
    public DateTime EndDate { get; set; }
    public MembershipStatus Status { get; set; } = MembershipStatus.Active;
}
