using GroundZero.Application.Common;
using GroundZero.Application.Features.Leaderboard.DTOs;
using GroundZero.Application.IRepositories;
using MediatR;

namespace GroundZero.Application.Features.Leaderboard.Queries;

public class GetLeaderboardQueryHandler : IRequestHandler<GetLeaderboardQuery, PagedResult<LeaderboardEntryResponse>>
{
    private readonly IUserRepository _userRepository;
    private readonly ILevelRepository _levelRepository;

    public GetLeaderboardQueryHandler(IUserRepository userRepository, ILevelRepository levelRepository)
    {
        _userRepository = userRepository;
        _levelRepository = levelRepository;
    }

    public async Task<PagedResult<LeaderboardEntryResponse>> Handle(GetLeaderboardQuery query, CancellationToken cancellationToken)
    {
        var levels = await _levelRepository.GetAllOrderedAsync(cancellationToken);
        var levelDict = levels.ToDictionary(l => l.Id, l => l.Name);

        var paged = await _userRepository.GetLeaderboardPagedAsync(
            query.PageNumber, query.PageSize, cancellationToken);

        var startRank = (query.PageNumber - 1) * query.PageSize + 1;

        var items = paged.Items.Select((user, index) => new LeaderboardEntryResponse
        {
            Rank = startRank + index,
            UserId = user.Id,
            UserFullName = $"{user.FirstName} {user.LastName}",
            ProfileImageUrl = user.ProfileImageUrl,
            Level = user.Level,
            LevelName = levelDict.TryGetValue(user.Level, out var name) ? name : string.Empty,
            XP = user.XP,
            TotalGymMinutes = user.TotalGymMinutes
        }).ToList();

        return new PagedResult<LeaderboardEntryResponse>
        {
            Items = items,
            TotalCount = paged.TotalCount,
            PageNumber = paged.PageNumber,
            PageSize = paged.PageSize
        };
    }
}
