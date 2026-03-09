namespace GroundZero.Messaging.Events;

public class MembershipExpiredEvent
{
    public string Email { get; set; } = string.Empty;
    public string UserName { get; set; } = string.Empty;
    public string PlanName { get; set; } = string.Empty;
    public DateTime ExpiredAt { get; set; }
}
