using GroundZero.Application.Features.Memberships.DTOs;
using MediatR;

namespace GroundZero.Application.Features.Memberships.Queries;

public class GetMembershipPlanByIdQuery : IRequest<MembershipPlanResponse>
{
    public int Id { get; set; }
}
