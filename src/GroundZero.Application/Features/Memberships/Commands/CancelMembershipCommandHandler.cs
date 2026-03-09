using GroundZero.Application.Exceptions;
using GroundZero.Application.Features.Memberships.DTOs;
using GroundZero.Application.IRepositories;
using GroundZero.Domain.Enums;
using GroundZero.Messaging;
using GroundZero.Messaging.Events;
using MediatR;

namespace GroundZero.Application.Features.Memberships.Commands;

public class CancelMembershipCommandHandler : IRequestHandler<CancelMembershipCommand, UserMembershipResponse>
{
    private readonly IMembershipRepository _membershipRepository;
    private readonly IMessagePublisher _messagePublisher;

    public CancelMembershipCommandHandler(
        IMembershipRepository membershipRepository,
        IMessagePublisher messagePublisher)
    {
        _membershipRepository = membershipRepository;
        _messagePublisher = messagePublisher;
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

        await _messagePublisher.PublishAsync(QueueNames.MembershipCancelled,
            new MembershipCancelledEvent
            {
                Email = membership.User.Email,
                UserName = $"{membership.User.FirstName} {membership.User.LastName}",
                PlanName = membership.MembershipPlan.Name,
                CancelledAt = DateTime.UtcNow
            }, cancellationToken);

        return membership.ToResponse();
    }
}
