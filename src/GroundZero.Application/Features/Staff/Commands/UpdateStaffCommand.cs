using GroundZero.Application.Common;
using GroundZero.Application.Features.Staff.DTOs;
using MediatR;

namespace GroundZero.Application.Features.Staff.Commands;

[AuthorizeRole("Admin")]
public class UpdateStaffCommand : IRequest<StaffResponse>
{
    public int Id { get; set; }
    public UpdateStaffRequest Request { get; set; } = null!;
}
