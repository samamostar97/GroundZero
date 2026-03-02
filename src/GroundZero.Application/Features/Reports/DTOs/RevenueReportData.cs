namespace GroundZero.Application.Features.Reports.DTOs;

public class RevenueReportData
{
    public DateTime From { get; set; }
    public DateTime To { get; set; }
    public decimal TotalOrderRevenue { get; set; }
    public int TotalOrders { get; set; }
    public int TotalAppointments { get; set; }
    public List<MonthlyRevenueItem> MonthlyRevenue { get; set; } = new();
    public List<CategoryRevenueItem> CategoryRevenue { get; set; } = new();
}

public class MonthlyRevenueItem
{
    public string Month { get; set; } = string.Empty;
    public int Year { get; set; }
    public decimal Revenue { get; set; }
    public int OrderCount { get; set; }
}

public class CategoryRevenueItem
{
    public string CategoryName { get; set; } = string.Empty;
    public decimal Revenue { get; set; }
    public int ItemsSold { get; set; }
}
