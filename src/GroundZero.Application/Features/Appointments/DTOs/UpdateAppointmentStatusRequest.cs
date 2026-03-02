using GroundZero.Domain.Enums;

namespace GroundZero.Application.Features.Appointments.DTOs;

public class UpdateAppointmentStatusRequest
{
    public AppointmentStatus Status { get; set; }
}
