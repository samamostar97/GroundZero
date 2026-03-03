using GroundZero.Application.Features.Memberships.DTOs;
using GroundZero.Application.IRepositories;
using GroundZero.Domain.Entities;
using MediatR;

namespace GroundZero.Application.Features.Memberships.Queries;

public class GetAllMembershipPlansQueryHandler : IRequestHandler<GetAllMembershipPlansQuery, List<MembershipPlanResponse>>
{
    private readonly IRepository<MembershipPlan> _planRepository;

    public GetAllMembershipPlansQueryHandler(IRepository<MembershipPlan> planRepository)
    {
        _planRepository = planRepository;
    }

    public async Task<List<MembershipPlanResponse>> Handle(GetAllMembershipPlansQuery query, CancellationToken cancellationToken)
    {
        List<MembershipPlan> plans;

        if (query.IsActive.HasValue)
            plans = await _planRepository.FindAsync(p => p.IsActive == query.IsActive.Value, cancellationToken);
        else
            plans = await _planRepository.GetAllAsync(cancellationToken);

        return plans.Select(p => p.ToResponse()).ToList();
    }
}
