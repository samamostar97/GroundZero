namespace GroundZero.Application.Features.Reports.DTOs;

public class UserReportData
{
    public DateTime From { get; set; }
    public DateTime To { get; set; }
    public int TotalUsers { get; set; }
    public int NewUsersInPeriod { get; set; }
    public int ActiveUsersInPeriod { get; set; }
    public double RetentionRate { get; set; }
    public List<MonthlyRegistrationItem> MonthlyRegistrations { get; set; } = new();
    public List<UserActivityItem> MostActiveUsers { get; set; } = new();
}

public class MonthlyRegistrationItem
{
    public string Month { get; set; } = string.Empty;
    public int Year { get; set; }
    public int Count { get; set; }
}

public class UserActivityItem
{
    public string FullName { get; set; } = string.Empty;
    public string Email { get; set; } = string.Empty;
    public int GymVisits { get; set; }
    public int TotalMinutes { get; set; }
}
