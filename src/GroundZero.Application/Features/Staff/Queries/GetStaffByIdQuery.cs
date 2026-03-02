using GroundZero.Application.Features.Staff.DTOs;
using MediatR;

namespace GroundZero.Application.Features.Staff.Queries;

public class GetStaffByIdQuery : IRequest<StaffResponse>
{
    public int Id { get; set; }
}
