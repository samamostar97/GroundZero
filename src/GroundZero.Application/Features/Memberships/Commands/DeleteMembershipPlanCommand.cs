using GroundZero.Application.Common;
using MediatR;

namespace GroundZero.Application.Features.Memberships.Commands;

[AuthorizeRole("Admin")]
public class DeleteMembershipPlanCommand : IRequest<Unit>
{
    public int Id { get; set; }
}
