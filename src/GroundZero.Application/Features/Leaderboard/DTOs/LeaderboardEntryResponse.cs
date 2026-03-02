namespace GroundZero.Application.Features.Leaderboard.DTOs;

public class LeaderboardEntryResponse
{
    public int Rank { get; set; }
    public int UserId { get; set; }
    public string UserFullName { get; set; } = string.Empty;
    public string? ProfileImageUrl { get; set; }
    public int Level { get; set; }
    public string LevelName { get; set; } = string.Empty;
    public int XP { get; set; }
    public int TotalGymMinutes { get; set; }
}
