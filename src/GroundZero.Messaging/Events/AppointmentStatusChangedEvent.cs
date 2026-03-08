namespace GroundZero.Messaging.Events;

public class AppointmentStatusChangedEvent
{
    public string Email { get; set; } = string.Empty;
    public string StaffName { get; set; } = string.Empty;
    public DateTime ScheduledAt { get; set; }
    public string NewStatus { get; set; } = string.Empty;
}
