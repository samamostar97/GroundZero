namespace GroundZero.Application.Features.Dashboard.DTOs;

public class ActivityFeedItemResponse
{
    public string Type { get; set; } = string.Empty; // CheckIn, CheckOut, Order, Appointment, Registration
    public string Message { get; set; } = string.Empty;
    public DateTime Timestamp { get; set; }
}
