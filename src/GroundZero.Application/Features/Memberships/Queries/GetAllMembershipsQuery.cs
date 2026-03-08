using GroundZero.Application.Common;
using GroundZero.Application.Features.Memberships.DTOs;
using GroundZero.Domain.Enums;
using MediatR;

namespace GroundZero.Application.Features.Memberships.Queries;

[AuthorizeRole("Admin")]
public class GetAllMembershipsQuery : IRequest<PagedResult<UserMembershipResponse>>
{
    public int PageNumber { get; set; } = 1;
    public int PageSize { get; set; } = 10;
    public string? Search { get; set; }
    public MembershipStatus? Status { get; set; }
    public int? UserId { get; set; }
    public string? SortBy { get; set; }
    public bool SortDescending { get; set; } = true;
}
