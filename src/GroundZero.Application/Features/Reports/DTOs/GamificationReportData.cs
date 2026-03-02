namespace GroundZero.Application.Features.Reports.DTOs;

public class GamificationReportData
{
    public DateTime From { get; set; }
    public DateTime To { get; set; }
    public int TotalGymVisits { get; set; }
    public double AvgVisitDurationMinutes { get; set; }
    public List<LevelDistributionItem> LevelDistribution { get; set; } = new();
    public List<LeaderboardSummaryItem> TopUsers { get; set; } = new();
    public List<DailyVisitItem> DailyVisits { get; set; } = new();
}

public class LevelDistributionItem
{
    public string LevelName { get; set; } = string.Empty;
    public int UserCount { get; set; }
}

public class LeaderboardSummaryItem
{
    public string FullName { get; set; } = string.Empty;
    public string Email { get; set; } = string.Empty;
    public int Level { get; set; }
    public int XP { get; set; }
    public int TotalGymMinutes { get; set; }
}

public class DailyVisitItem
{
    public DateTime Date { get; set; }
    public int VisitCount { get; set; }
    public double AvgDurationMinutes { get; set; }
}
