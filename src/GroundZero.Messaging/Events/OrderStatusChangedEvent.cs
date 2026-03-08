namespace GroundZero.Messaging.Events;

public class OrderStatusChangedEvent
{
    public string Email { get; set; } = string.Empty;
    public int OrderId { get; set; }
    public string NewStatus { get; set; } = string.Empty;
}
