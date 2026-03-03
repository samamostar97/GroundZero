using GroundZero.Application.Common;
using GroundZero.Application.Features.Memberships.DTOs;
using MediatR;

namespace GroundZero.Application.Features.Memberships.Commands;

[AuthorizeRole("Admin")]
public class AssignMembershipCommand : IRequest<UserMembershipResponse>
{
    public AssignMembershipRequest Request { get; set; } = null!;
}
