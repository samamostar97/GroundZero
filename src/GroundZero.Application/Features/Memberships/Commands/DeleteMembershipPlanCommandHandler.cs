using GroundZero.Application.Exceptions;
using GroundZero.Application.IRepositories;
using GroundZero.Domain.Entities;
using MediatR;

namespace GroundZero.Application.Features.Memberships.Commands;

public class DeleteMembershipPlanCommandHandler : IRequestHandler<DeleteMembershipPlanCommand, Unit>
{
    private readonly IRepository<MembershipPlan> _planRepository;

    public DeleteMembershipPlanCommandHandler(IRepository<MembershipPlan> planRepository)
    {
        _planRepository = planRepository;
    }

    public async Task<Unit> Handle(DeleteMembershipPlanCommand command, CancellationToken cancellationToken)
    {
        var plan = await _planRepository.GetByIdAsync(command.Id, cancellationToken)
            ?? throw new NotFoundException("Plan članarine", command.Id);

        _planRepository.SoftDelete(plan);
        await _planRepository.SaveChangesAsync(cancellationToken);

        return Unit.Value;
    }
}
