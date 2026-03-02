using GroundZero.Domain.Enums;

namespace GroundZero.Domain.Entities;

public class Appointment : BaseEntity
{
    public int UserId { get; set; }
    public User User { get; set; } = null!;
    public int StaffId { get; set; }
    public Staff Staff { get; set; } = null!;
    public DateTime ScheduledAt { get; set; }
    public int DurationMinutes { get; set; }
    public AppointmentStatus Status { get; set; } = AppointmentStatus.Pending;
    public string? Notes { get; set; }
}
