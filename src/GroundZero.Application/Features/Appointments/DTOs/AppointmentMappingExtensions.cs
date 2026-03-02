using GroundZero.Domain.Entities;

namespace GroundZero.Application.Features.Appointments.DTOs;

public static class AppointmentMappingExtensions
{
    public static AppointmentResponse ToResponse(this Appointment appointment)
    {
        return new AppointmentResponse
        {
            Id = appointment.Id,
            UserId = appointment.UserId,
            UserFullName = $"{appointment.User.FirstName} {appointment.User.LastName}",
            StaffId = appointment.StaffId,
            StaffFullName = $"{appointment.Staff.FirstName} {appointment.Staff.LastName}",
            StaffType = appointment.Staff.StaffType.ToString(),
            ScheduledAt = appointment.ScheduledAt,
            DurationMinutes = appointment.DurationMinutes,
            Status = appointment.Status.ToString(),
            Notes = appointment.Notes,
            CreatedAt = appointment.CreatedAt
        };
    }
}
