using GroundZero.Application.Features.Staff.DTOs;
using MediatR;

namespace GroundZero.Application.Features.Staff.Queries;

public class GetStaffAvailableSlotsQuery : IRequest<List<TimeSlotResponse>>
{
    public int StaffId { get; set; }
    public DateTime Date { get; set; }
}
