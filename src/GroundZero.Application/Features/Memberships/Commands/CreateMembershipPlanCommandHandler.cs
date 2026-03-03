using GroundZero.Application.Features.Memberships.DTOs;
using GroundZero.Application.IRepositories;
using GroundZero.Domain.Entities;
using MediatR;

namespace GroundZero.Application.Features.Memberships.Commands;

public class CreateMembershipPlanCommandHandler : IRequestHandler<CreateMembershipPlanCommand, MembershipPlanResponse>
{
    private readonly IRepository<MembershipPlan> _planRepository;

    public CreateMembershipPlanCommandHandler(IRepository<MembershipPlan> planRepository)
    {
        _planRepository = planRepository;
    }

    public async Task<MembershipPlanResponse> Handle(CreateMembershipPlanCommand command, CancellationToken cancellationToken)
    {
        var plan = new MembershipPlan
        {
            Name = command.Request.Name,
            Description = command.Request.Description,
            Price = command.Request.Price,
            DurationDays = command.Request.DurationDays
        };

        await _planRepository.AddAsync(plan, cancellationToken);
        await _planRepository.SaveChangesAsync(cancellationToken);

        return plan.ToResponse();
    }
}
