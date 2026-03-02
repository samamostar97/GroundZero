namespace GroundZero.Application.Features.Appointments.DTOs;

public class CreateAppointmentRequest
{
    public int StaffId { get; set; }
    public DateTime ScheduledAt { get; set; }
    public int DurationMinutes { get; set; }
    public string? Notes { get; set; }
}
