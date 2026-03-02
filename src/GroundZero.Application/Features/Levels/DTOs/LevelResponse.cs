namespace GroundZero.Application.Features.Levels.DTOs;

public class LevelResponse
{
    public int Id { get; set; }
    public string Name { get; set; } = string.Empty;
    public int MinXP { get; set; }
    public int MaxXP { get; set; }
    public string? BadgeImageUrl { get; set; }
}
