using GroundZero.Application.Features.Memberships.DTOs;
using MediatR;

namespace GroundZero.Application.Features.Memberships.Queries;

public class GetAllMembershipPlansQuery : IRequest<List<MembershipPlanResponse>>
{
    public bool? IsActive { get; set; }
}
