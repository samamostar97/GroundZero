using GroundZero.Application.Exceptions;
using GroundZero.Application.Features.Memberships.DTOs;
using GroundZero.Application.IRepositories;
using GroundZero.Domain.Entities;
using MediatR;

namespace GroundZero.Application.Features.Memberships.Commands;

public class UpdateMembershipPlanCommandHandler : IRequestHandler<UpdateMembershipPlanCommand, MembershipPlanResponse>
{
    private readonly IRepository<MembershipPlan> _planRepository;

    public UpdateMembershipPlanCommandHandler(IRepository<MembershipPlan> planRepository)
    {
        _planRepository = planRepository;
    }

    public async Task<MembershipPlanResponse> Handle(UpdateMembershipPlanCommand command, CancellationToken cancellationToken)
    {
        var plan = await _planRepository.GetByIdAsync(command.Id, cancellationToken)
            ?? throw new NotFoundException("Plan članarine", command.Id);

        plan.Name = command.Request.Name;
        plan.Description = command.Request.Description;
        plan.Price = command.Request.Price;
        plan.DurationDays = command.Request.DurationDays;
        plan.IsActive = command.Request.IsActive;

        _planRepository.Update(plan);
        await _planRepository.SaveChangesAsync(cancellationToken);

        return plan.ToResponse();
    }
}
