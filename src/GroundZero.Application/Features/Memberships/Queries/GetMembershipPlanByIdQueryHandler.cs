using GroundZero.Application.Exceptions;
using GroundZero.Application.Features.Memberships.DTOs;
using GroundZero.Application.IRepositories;
using GroundZero.Domain.Entities;
using MediatR;

namespace GroundZero.Application.Features.Memberships.Queries;

public class GetMembershipPlanByIdQueryHandler : IRequestHandler<GetMembershipPlanByIdQuery, MembershipPlanResponse>
{
    private readonly IRepository<MembershipPlan> _planRepository;

    public GetMembershipPlanByIdQueryHandler(IRepository<MembershipPlan> planRepository)
    {
        _planRepository = planRepository;
    }

    public async Task<MembershipPlanResponse> Handle(GetMembershipPlanByIdQuery query, CancellationToken cancellationToken)
    {
        var plan = await _planRepository.GetByIdAsync(query.Id, cancellationToken)
            ?? throw new NotFoundException("Plan članarine", query.Id);

        return plan.ToResponse();
    }
}
