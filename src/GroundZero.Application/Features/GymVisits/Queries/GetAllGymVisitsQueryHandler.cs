using GroundZero.Application.Common;
using GroundZero.Application.Features.GymVisits.DTOs;
using GroundZero.Application.IRepositories;
using MediatR;

namespace GroundZero.Application.Features.GymVisits.Queries;

public class GetAllGymVisitsQueryHandler : IRequestHandler<GetAllGymVisitsQuery, PagedResult<GymVisitResponse>>
{
    private readonly IGymVisitRepository _gymVisitRepository;

    public GetAllGymVisitsQueryHandler(IGymVisitRepository gymVisitRepository)
    {
        _gymVisitRepository = gymVisitRepository;
    }

    public async Task<PagedResult<GymVisitResponse>> Handle(GetAllGymVisitsQuery query, CancellationToken cancellationToken)
    {
        var paged = await _gymVisitRepository.GetAllVisitsPagedAsync(
            query.Search, query.PageNumber, query.PageSize, cancellationToken);

        return new PagedResult<GymVisitResponse>
        {
            Items = paged.Items.Select(v => v.ToResponse(v.DurationMinutes.HasValue ? v.DurationMinutes.Value / 10 : 0)).ToList(),
            TotalCount = paged.TotalCount,
            PageNumber = paged.PageNumber,
            PageSize = paged.PageSize
        };
    }
}
