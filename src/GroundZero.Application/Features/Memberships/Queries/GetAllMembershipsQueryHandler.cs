using GroundZero.Application.Common;
using GroundZero.Application.Features.Memberships.DTOs;
using GroundZero.Application.IRepositories;
using MediatR;

namespace GroundZero.Application.Features.Memberships.Queries;

public class GetAllMembershipsQueryHandler : IRequestHandler<GetAllMembershipsQuery, PagedResult<UserMembershipResponse>>
{
    private readonly IMembershipRepository _membershipRepository;

    public GetAllMembershipsQueryHandler(IMembershipRepository membershipRepository)
    {
        _membershipRepository = membershipRepository;
    }

    public async Task<PagedResult<UserMembershipResponse>> Handle(GetAllMembershipsQuery query, CancellationToken cancellationToken)
    {
        var paged = await _membershipRepository.GetAllMembershipsPagedAsync(
            query.Search, query.Status, query.UserId,
            query.PageNumber, query.PageSize, cancellationToken);

        return new PagedResult<UserMembershipResponse>
        {
            Items = paged.Items.Select(m => m.ToResponse()).ToList(),
            TotalCount = paged.TotalCount,
            PageNumber = paged.PageNumber,
            PageSize = paged.PageSize
        };
    }
}
