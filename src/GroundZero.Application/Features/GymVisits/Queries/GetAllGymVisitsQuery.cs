using GroundZero.Application.Common;
using GroundZero.Application.Features.GymVisits.DTOs;
using MediatR;

namespace GroundZero.Application.Features.GymVisits.Queries;

[AuthorizeRole("Admin")]
public class GetAllGymVisitsQuery : IRequest<PagedResult<GymVisitResponse>>
{
    public int PageNumber { get; set; } = 1;
    public int PageSize { get; set; } = 10;
    public string? Search { get; set; }
}
