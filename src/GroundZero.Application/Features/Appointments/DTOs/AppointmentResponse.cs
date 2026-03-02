namespace GroundZero.Application.Features.Appointments.DTOs;

public class AppointmentResponse
{
    public int Id { get; set; }
    public int UserId { get; set; }
    public string UserFullName { get; set; } = string.Empty;
    public int StaffId { get; set; }
    public string StaffFullName { get; set; } = string.Empty;
    public string StaffType { get; set; } = string.Empty;
    public DateTime ScheduledAt { get; set; }
    public int DurationMinutes { get; set; }
    public string Status { get; set; } = string.Empty;
    public string? Notes { get; set; }
    public DateTime CreatedAt { get; set; }
}
