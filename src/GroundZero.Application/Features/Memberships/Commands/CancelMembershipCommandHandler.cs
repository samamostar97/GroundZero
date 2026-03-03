using GroundZero.Application.Exceptions;
using GroundZero.Application.Features.Memberships.DTOs;
using GroundZero.Application.IRepositories;
using GroundZero.Domain.Enums;
using MediatR;

namespace GroundZero.Application.Features.Memberships.Commands;

public class CancelMembershipCommandHandler : IRequestHandler<CancelMembershipCommand, UserMembershipResponse>
{
    private readonly IMembershipRepository _membershipRepository;

    public CancelMembershipCommandHandler(IMembershipRepository membershipRepository)
    {
        _membershipRepository = membershipRepository;
    }

    public async Task<UserMembershipResponse> Handle(CancelMembershipCommand command, CancellationToken cancellationToken)
    {
        var membership = await _membershipRepository.GetByIdWithDetailsAsync(command.Id, cancellationToken)
            ?? throw new NotFoundException("Članarina", command.Id);

        if (membership.Status == MembershipStatus.Cancelled)
            throw new InvalidOperationException("Članarina je već otkazana.");

        membership.Status = MembershipStatus.Cancelled;

        _membershipRepository.Update(membership);
        await _membershipRepository.SaveChangesAsync(cancellationToken);

        return membership.ToResponse();
    }
}
