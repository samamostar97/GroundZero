using GroundZero.Application.Common;
using GroundZero.Application.Features.Staff.DTOs;
using MediatR;

namespace GroundZero.Application.Features.Staff.Commands;

public class UpdateStaffCommand : IRequest<ApiResponse<StaffResponse>>
{
    public int Id { get; set; }
    public UpdateStaffRequest Request { get; set; } = null!;
}
