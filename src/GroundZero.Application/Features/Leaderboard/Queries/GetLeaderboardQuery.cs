using GroundZero.Application.Common;
using GroundZero.Application.Features.Leaderboard.DTOs;
using MediatR;

namespace GroundZero.Application.Features.Leaderboard.Queries;

public class GetLeaderboardQuery : IRequest<PagedResult<LeaderboardEntryResponse>>
{
    public int PageNumber { get; set; } = 1;
    public int PageSize { get; set; } = 10;
}
