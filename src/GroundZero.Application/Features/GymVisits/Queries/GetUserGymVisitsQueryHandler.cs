using GroundZero.Application.Common;
using GroundZero.Application.Features.GymVisits.DTOs;
using GroundZero.Application.IRepositories;
using GroundZero.Application.IServices;
using MediatR;

namespace GroundZero.Application.Features.GymVisits.Queries;

public class GetUserGymVisitsQueryHandler : IRequestHandler<GetUserGymVisitsQuery, PagedResult<GymVisitResponse>>
{
    private readonly IGymVisitRepository _gymVisitRepository;
    private readonly ICurrentUserService _currentUserService;

    public GetUserGymVisitsQueryHandler(IGymVisitRepository gymVisitRepository, ICurrentUserService currentUserService)
    {
        _gymVisitRepository = gymVisitRepository;
        _currentUserService = currentUserService;
    }

    public async Task<PagedResult<GymVisitResponse>> Handle(GetUserGymVisitsQuery query, CancellationToken cancellationToken)
    {
        var userId = _currentUserService.UserId!.Value;

        var paged = await _gymVisitRepository.GetUserVisitsPagedAsync(
            userId, query.PageNumber, query.PageSize, cancellationToken);

        return new PagedResult<GymVisitResponse>
        {
            Items = paged.Items.Select(v => v.ToResponse(v.DurationMinutes.HasValue ? v.DurationMinutes.Value / 10 : 0)).ToList(),
            TotalCount = paged.TotalCount,
            PageNumber = paged.PageNumber,
            PageSize = paged.PageSize
        };
    }
}
