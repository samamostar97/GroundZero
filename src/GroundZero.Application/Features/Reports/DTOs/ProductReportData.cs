namespace GroundZero.Application.Features.Reports.DTOs;

public class ProductReportData
{
    public DateTime From { get; set; }
    public DateTime To { get; set; }
    public int TotalProducts { get; set; }
    public int OutOfStockCount { get; set; }
    public List<BestSellerItem> BestSellers { get; set; } = new();
    public List<StockLevelItem> StockLevels { get; set; } = new();
    public List<LowStockAlertItem> LowStockAlerts { get; set; } = new();
}

public class BestSellerItem
{
    public string ProductName { get; set; } = string.Empty;
    public string CategoryName { get; set; } = string.Empty;
    public int QuantitySold { get; set; }
    public decimal TotalRevenue { get; set; }
}

public class StockLevelItem
{
    public string ProductName { get; set; } = string.Empty;
    public string CategoryName { get; set; } = string.Empty;
    public int StockQuantity { get; set; }
    public decimal Price { get; set; }
}

public class LowStockAlertItem
{
    public string ProductName { get; set; } = string.Empty;
    public string CategoryName { get; set; } = string.Empty;
    public int StockQuantity { get; set; }
}
