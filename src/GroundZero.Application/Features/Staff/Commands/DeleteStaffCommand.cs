using GroundZero.Application.Common;
using MediatR;

namespace GroundZero.Application.Features.Staff.Commands;

public class DeleteStaffCommand : IRequest<ApiResponse<string>>
{
    public int Id { get; set; }
}
