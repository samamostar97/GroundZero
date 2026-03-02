using GroundZero.Application.Common;
using GroundZero.Application.Features.Staff.DTOs;
using MediatR;

namespace GroundZero.Application.Features.Staff.Commands;

public class CreateStaffCommand : IRequest<ApiResponse<StaffResponse>>
{
    public CreateStaffRequest Request { get; set; } = null!;
}
