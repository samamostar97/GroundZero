using GroundZero.Application.Features.Levels.DTOs;
using GroundZero.Application.IRepositories;
using MediatR;

namespace GroundZero.Application.Features.Levels.Queries;

public class GetLevelsQueryHandler : IRequestHandler<GetLevelsQuery, List<LevelResponse>>
{
    private readonly ILevelRepository _levelRepository;

    public GetLevelsQueryHandler(ILevelRepository levelRepository)
    {
        _levelRepository = levelRepository;
    }

    public async Task<List<LevelResponse>> Handle(GetLevelsQuery query, CancellationToken cancellationToken)
    {
        var levels = await _levelRepository.GetAllOrderedAsync(cancellationToken);
        return levels.Select(l => l.ToResponse()).ToList();
    }
}
