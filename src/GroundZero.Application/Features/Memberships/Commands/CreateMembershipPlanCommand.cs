using GroundZero.Application.Common;
using GroundZero.Application.Features.Memberships.DTOs;
using MediatR;

namespace GroundZero.Application.Features.Memberships.Commands;

[AuthorizeRole("Admin")]
public class CreateMembershipPlanCommand : IRequest<MembershipPlanResponse>
{
    public CreateMembershipPlanRequest Request { get; set; } = null!;
}
