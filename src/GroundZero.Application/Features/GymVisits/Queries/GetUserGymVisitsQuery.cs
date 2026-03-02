using GroundZero.Application.Common;
using GroundZero.Application.Features.GymVisits.DTOs;
using MediatR;

namespace GroundZero.Application.Features.GymVisits.Queries;

[AuthorizeRole("User")]
public class GetUserGymVisitsQuery : IRequest<PagedResult<GymVisitResponse>>
{
    public int PageNumber { get; set; } = 1;
    public int PageSize { get; set; } = 10;
}
