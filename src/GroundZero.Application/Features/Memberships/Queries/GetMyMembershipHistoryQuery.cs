using GroundZero.Application.Common;
using GroundZero.Application.Features.Memberships.DTOs;
using MediatR;

namespace GroundZero.Application.Features.Memberships.Queries;

[AuthorizeRole("User")]
public class GetMyMembershipHistoryQuery : IRequest<PagedResult<UserMembershipResponse>>
{
    public int PageNumber { get; set; } = 1;
    public int PageSize { get; set; } = 10;
}
