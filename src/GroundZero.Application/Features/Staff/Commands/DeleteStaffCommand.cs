using GroundZero.Application.Common;
using MediatR;

namespace GroundZero.Application.Features.Staff.Commands;

[AuthorizeRole("Admin")]
public class DeleteStaffCommand : IRequest<Unit>
{
    public int Id { get; set; }
}
