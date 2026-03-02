using GroundZero.Domain.Entities;

namespace GroundZero.Application.Features.Levels.DTOs;

public static class LevelMappingExtensions
{
    public static LevelResponse ToResponse(this Level level)
    {
        return new LevelResponse
        {
            Id = level.Id,
            Name = level.Name,
            MinXP = level.MinXP,
            MaxXP = level.MaxXP,
            BadgeImageUrl = level.BadgeImageUrl
        };
    }
}
