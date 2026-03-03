using GroundZero.Application.Common;
using GroundZero.Application.Features.Memberships.DTOs;
using GroundZero.Application.IRepositories;
using GroundZero.Application.IServices;
using MediatR;

namespace GroundZero.Application.Features.Memberships.Queries;

public class GetMyMembershipHistoryQueryHandler : IRequestHandler<GetMyMembershipHistoryQuery, PagedResult<UserMembershipResponse>>
{
    private readonly IMembershipRepository _membershipRepository;
    private readonly ICurrentUserService _currentUserService;

    public GetMyMembershipHistoryQueryHandler(IMembershipRepository membershipRepository, ICurrentUserService currentUserService)
    {
        _membershipRepository = membershipRepository;
        _currentUserService = currentUserService;
    }

    public async Task<PagedResult<UserMembershipResponse>> Handle(GetMyMembershipHistoryQuery query, CancellationToken cancellationToken)
    {
        var userId = _currentUserService.UserId
            ?? throw new UnauthorizedAccessException("Morate biti prijavljeni.");

        var paged = await _membershipRepository.GetUserMembershipHistoryPagedAsync(
            userId, query.PageNumber, query.PageSize, cancellationToken);

        return new PagedResult<UserMembershipResponse>
        {
            Items = paged.Items.Select(m => m.ToResponse()).ToList(),
            TotalCount = paged.TotalCount,
            PageNumber = paged.PageNumber,
            PageSize = paged.PageSize
        };
    }
}
