using GroundZero.Application.Exceptions;
using GroundZero.Application.Features.Users.DTOs;
using GroundZero.Application.IRepositories;
using GroundZero.Application.IServices;
using MediatR;

namespace GroundZero.Application.Features.Users.Queries;

public class GetMyGamificationQueryHandler : IRequestHandler<GetMyGamificationQuery, GamificationResponse>
{
    private readonly IUserRepository _userRepository;
    private readonly ILevelRepository _levelRepository;
    private readonly ICurrentUserService _currentUserService;

    public GetMyGamificationQueryHandler(
        IUserRepository userRepository,
        ILevelRepository levelRepository,
        ICurrentUserService currentUserService)
    {
        _userRepository = userRepository;
        _levelRepository = levelRepository;
        _currentUserService = currentUserService;
    }

    public async Task<GamificationResponse> Handle(GetMyGamificationQuery query, CancellationToken cancellationToken)
    {
        var userId = _currentUserService.UserId!.Value;

        var user = await _userRepository.GetByIdAsync(userId, cancellationToken)
            ?? throw new NotFoundException("Korisnik", userId);

        var levels = await _levelRepository.GetAllOrderedAsync(cancellationToken);
        var currentLevel = levels.FirstOrDefault(l => l.Id == user.Level);
        var nextLevel = levels.FirstOrDefault(l => l.Id == user.Level + 1);

        var rank = await _userRepository.GetUserRankAsync(userId, cancellationToken);

        return new GamificationResponse
        {
            XP = user.XP,
            Level = user.Level,
            LevelName = currentLevel?.Name ?? string.Empty,
            TotalGymMinutes = user.TotalGymMinutes,
            Rank = rank,
            NextLevelXP = nextLevel?.MinXP
        };
    }
}
