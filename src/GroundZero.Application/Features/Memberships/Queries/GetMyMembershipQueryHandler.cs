using GroundZero.Application.Features.Memberships.DTOs;
using GroundZero.Application.IRepositories;
using GroundZero.Application.IServices;
using MediatR;

namespace GroundZero.Application.Features.Memberships.Queries;

public class GetMyMembershipQueryHandler : IRequestHandler<GetMyMembershipQuery, UserMembershipResponse?>
{
    private readonly IMembershipRepository _membershipRepository;
    private readonly ICurrentUserService _currentUserService;

    public GetMyMembershipQueryHandler(IMembershipRepository membershipRepository, ICurrentUserService currentUserService)
    {
        _membershipRepository = membershipRepository;
        _currentUserService = currentUserService;
    }

    public async Task<UserMembershipResponse?> Handle(GetMyMembershipQuery query, CancellationToken cancellationToken)
    {
        var userId = _currentUserService.UserId
            ?? throw new UnauthorizedAccessException("Morate biti prijavljeni.");

        var membership = await _membershipRepository.GetCurrentMembershipForUserAsync(userId, cancellationToken);

        return membership?.ToResponse();
    }
}
