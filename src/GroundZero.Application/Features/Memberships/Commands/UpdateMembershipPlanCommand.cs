using GroundZero.Application.Common;
using GroundZero.Application.Features.Memberships.DTOs;
using MediatR;

namespace GroundZero.Application.Features.Memberships.Commands;

[AuthorizeRole("Admin")]
public class UpdateMembershipPlanCommand : IRequest<MembershipPlanResponse>
{
    public int Id { get; set; }
    public UpdateMembershipPlanRequest Request { get; set; } = null!;
}
