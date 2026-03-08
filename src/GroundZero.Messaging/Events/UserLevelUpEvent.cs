namespace GroundZero.Messaging.Events;

public class UserLevelUpEvent
{
    public string Email { get; set; } = string.Empty;
    public string UserName { get; set; } = string.Empty;
    public int NewLevel { get; set; }
}
