using GroundZero.Application.Exceptions;
using GroundZero.Application.Features.Memberships.DTOs;
using GroundZero.Application.IRepositories;
using GroundZero.Domain.Entities;
using GroundZero.Domain.Enums;
using MediatR;

namespace GroundZero.Application.Features.Memberships.Commands;

public class AssignMembershipCommandHandler : IRequestHandler<AssignMembershipCommand, UserMembershipResponse>
{
    private readonly IMembershipRepository _membershipRepository;
    private readonly IUserRepository _userRepository;
    private readonly IRepository<MembershipPlan> _planRepository;

    public AssignMembershipCommandHandler(
        IMembershipRepository membershipRepository,
        IUserRepository userRepository,
        IRepository<MembershipPlan> planRepository)
    {
        _membershipRepository = membershipRepository;
        _userRepository = userRepository;
        _planRepository = planRepository;
    }

    public async Task<UserMembershipResponse> Handle(AssignMembershipCommand command, CancellationToken cancellationToken)
    {
        var user = await _userRepository.GetByIdAsync(command.Request.UserId, cancellationToken)
            ?? throw new NotFoundException("Korisnik", command.Request.UserId);

        var plan = await _planRepository.GetByIdAsync(command.Request.MembershipPlanId, cancellationToken)
            ?? throw new NotFoundException("Plan članarine", command.Request.MembershipPlanId);

        if (!plan.IsActive)
            throw new InvalidOperationException("Odabrani plan članarine nije aktivan.");

        var currentMembership = await _membershipRepository.GetCurrentMembershipForUserAsync(user.Id, cancellationToken);
        if (currentMembership != null && currentMembership.Status == MembershipStatus.Active && currentMembership.EndDate > DateTime.UtcNow)
            throw new InvalidOperationException("Korisnik već ima aktivnu članarinu.");

        var membership = new UserMembership
        {
            UserId = user.Id,
            MembershipPlanId = plan.Id,
            StartDate = command.Request.StartDate,
            EndDate = command.Request.StartDate.AddDays(plan.DurationDays),
            Status = MembershipStatus.Active
        };

        await _membershipRepository.AddAsync(membership, cancellationToken);
        await _membershipRepository.SaveChangesAsync(cancellationToken);

        membership.User = user;
        membership.MembershipPlan = plan;

        return membership.ToResponse();
    }
}
