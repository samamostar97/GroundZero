using GroundZero.Application.Common;
using GroundZero.Application.Features.Staff.DTOs;
using MediatR;

namespace GroundZero.Application.Features.Staff.Queries;

public class GetStaffByIdQuery : IRequest<ApiResponse<StaffResponse>>
{
    public int Id { get; set; }
}
