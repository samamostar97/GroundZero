namespace GroundZero.Application.Features.Users.DTOs;

public class GamificationResponse
{
    public int XP { get; set; }
    public int Level { get; set; }
    public string LevelName { get; set; } = string.Empty;
    public int TotalGymMinutes { get; set; }
    public int Rank { get; set; }
    public int? NextLevelXP { get; set; }
}
