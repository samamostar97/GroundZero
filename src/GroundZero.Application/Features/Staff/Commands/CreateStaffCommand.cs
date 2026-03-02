using GroundZero.Application.Common;
using GroundZero.Application.Features.Staff.DTOs;
using MediatR;

namespace GroundZero.Application.Features.Staff.Commands;

[AuthorizeRole("Admin")]
public class CreateStaffCommand : IRequest<StaffResponse>
{
    public CreateStaffRequest Request { get; set; } = null!;
}
