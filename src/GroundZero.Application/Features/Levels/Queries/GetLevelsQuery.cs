using GroundZero.Application.Features.Levels.DTOs;
using MediatR;

namespace GroundZero.Application.Features.Levels.Queries;

public class GetLevelsQuery : IRequest<List<LevelResponse>>
{
}
