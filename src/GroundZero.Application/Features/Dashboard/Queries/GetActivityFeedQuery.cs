using GroundZero.Application.Common;
using GroundZero.Application.Features.Dashboard.DTOs;
using MediatR;

namespace GroundZero.Application.Features.Dashboard.Queries;

[AuthorizeRole("Admin")]
public class GetActivityFeedQuery : IRequest<List<ActivityFeedItemResponse>>
{
    public int Count { get; set; } = 20;
}
