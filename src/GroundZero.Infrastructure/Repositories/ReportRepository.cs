using GroundZero.Application.Features.Reports.DTOs;
using GroundZero.Application.IRepositories;
using GroundZero.Domain.Enums;
using GroundZero.Infrastructure.Data;
using Microsoft.EntityFrameworkCore;

namespace GroundZero.Infrastructure.Repositories;

public class ReportRepository : IReportRepository
{
    private readonly ApplicationDbContext _context;

    private static readonly string[] BosnianMonths =
    {
        "Januar", "Februar", "Mart", "April", "Maj", "Juni",
        "Juli", "August", "Septembar", "Oktobar", "Novembar", "Decembar"
    };

    public ReportRepository(ApplicationDbContext context)
    {
        _context = context;
    }

    public async Task<RevenueReportData> GetRevenueReportAsync(DateTime from, DateTime to)
    {
        var validStatuses = new[] { OrderStatus.Confirmed, OrderStatus.Shipped, OrderStatus.Delivered };

        var orders = await _context.Orders
            .Where(o => o.CreatedAt >= from && o.CreatedAt <= to && validStatuses.Contains(o.Status))
            .ToListAsync();

        var totalOrderRevenue = orders.Sum(o => o.TotalAmount);
        var totalOrders = orders.Count;

        var totalAppointments = await _context.Appointments
            .CountAsync(a => a.CreatedAt >= from && a.CreatedAt <= to);

        var monthlyRevenue = orders
            .GroupBy(o => new { o.CreatedAt.Year, o.CreatedAt.Month })
            .Select(g => new MonthlyRevenueItem
            {
                Month = BosnianMonths[g.Key.Month - 1],
                Year = g.Key.Year,
                Revenue = g.Sum(o => o.TotalAmount),
                OrderCount = g.Count()
            })
            .OrderBy(m => m.Year).ThenBy(m => Array.IndexOf(BosnianMonths, m.Month))
            .ToList();

        var orderItems = await _context.OrderItems
            .Include(oi => oi.Product)
                .ThenInclude(p => p.Category)
            .Include(oi => oi.Order)
            .Where(oi => oi.Order.CreatedAt >= from && oi.Order.CreatedAt <= to
                         && validStatuses.Contains(oi.Order.Status))
            .ToListAsync();

        var categoryRevenue = orderItems
            .GroupBy(oi => oi.Product.Category.Name)
            .Select(g => new CategoryRevenueItem
            {
                CategoryName = g.Key,
                Revenue = g.Sum(oi => oi.Quantity * oi.UnitPrice),
                ItemsSold = g.Sum(oi => oi.Quantity)
            })
            .OrderByDescending(c => c.Revenue)
            .ToList();

        return new RevenueReportData
        {
            From = from,
            To = to,
            TotalOrderRevenue = totalOrderRevenue,
            TotalOrders = totalOrders,
            TotalAppointments = totalAppointments,
            MonthlyRevenue = monthlyRevenue,
            CategoryRevenue = categoryRevenue
        };
    }

    public async Task<ProductReportData> GetProductReportAsync(DateTime from, DateTime to, int lowStockThreshold)
    {
        var products = await _context.Products
            .Include(p => p.Category)
            .ToListAsync();

        var totalProducts = products.Count;
        var outOfStockCount = products.Count(p => p.StockQuantity == 0);

        var validStatuses = new[] { OrderStatus.Confirmed, OrderStatus.Shipped, OrderStatus.Delivered };

        var orderItems = await _context.OrderItems
            .Include(oi => oi.Product)
                .ThenInclude(p => p.Category)
            .Include(oi => oi.Order)
            .Where(oi => oi.Order.CreatedAt >= from && oi.Order.CreatedAt <= to
                         && validStatuses.Contains(oi.Order.Status))
            .ToListAsync();

        var bestSellers = orderItems
            .GroupBy(oi => new { oi.ProductId, oi.Product.Name, CategoryName = oi.Product.Category.Name })
            .Select(g => new BestSellerItem
            {
                ProductName = g.Key.Name,
                CategoryName = g.Key.CategoryName,
                QuantitySold = g.Sum(oi => oi.Quantity),
                TotalRevenue = g.Sum(oi => oi.Quantity * oi.UnitPrice)
            })
            .OrderByDescending(b => b.QuantitySold)
            .Take(20)
            .ToList();

        var stockLevels = products
            .OrderBy(p => p.StockQuantity)
            .Select(p => new StockLevelItem
            {
                ProductName = p.Name,
                CategoryName = p.Category.Name,
                StockQuantity = p.StockQuantity,
                Price = p.Price
            })
            .ToList();

        var lowStockAlerts = products
            .Where(p => p.StockQuantity <= lowStockThreshold)
            .OrderBy(p => p.StockQuantity)
            .Select(p => new LowStockAlertItem
            {
                ProductName = p.Name,
                CategoryName = p.Category.Name,
                StockQuantity = p.StockQuantity
            })
            .ToList();

        return new ProductReportData
        {
            From = from,
            To = to,
            TotalProducts = totalProducts,
            OutOfStockCount = outOfStockCount,
            BestSellers = bestSellers,
            StockLevels = stockLevels,
            LowStockAlerts = lowStockAlerts
        };
    }

    public async Task<UserReportData> GetUserReportAsync(DateTime from, DateTime to)
    {
        var users = await _context.Users
            .Where(u => u.Role == Role.User)
            .ToListAsync();

        var totalUsers = users.Count;
        var newUsersInPeriod = users.Count(u => u.CreatedAt >= from && u.CreatedAt <= to);

        var activeUserIds = await _context.GymVisits
            .Where(gv => gv.CheckInAt >= from && gv.CheckInAt <= to)
            .Select(gv => gv.UserId)
            .Distinct()
            .CountAsync();

        var retentionRate = totalUsers > 0 ? (double)activeUserIds / totalUsers * 100 : 0;

        var monthlyRegistrations = users
            .Where(u => u.CreatedAt >= from && u.CreatedAt <= to)
            .GroupBy(u => new { u.CreatedAt.Year, u.CreatedAt.Month })
            .Select(g => new MonthlyRegistrationItem
            {
                Month = BosnianMonths[g.Key.Month - 1],
                Year = g.Key.Year,
                Count = g.Count()
            })
            .OrderBy(m => m.Year).ThenBy(m => Array.IndexOf(BosnianMonths, m.Month))
            .ToList();

        var gymVisitsInPeriod = await _context.GymVisits
            .Where(gv => gv.CheckInAt >= from && gv.CheckInAt <= to && gv.DurationMinutes.HasValue)
            .ToListAsync();

        var mostActiveUsers = gymVisitsInPeriod
            .GroupBy(gv => gv.UserId)
            .Select(g =>
            {
                var user = users.FirstOrDefault(u => u.Id == g.Key);
                return new UserActivityItem
                {
                    FullName = user != null ? $"{user.FirstName} {user.LastName}" : "Nepoznat",
                    Email = user?.Email ?? "",
                    GymVisits = g.Count(),
                    TotalMinutes = g.Sum(gv => gv.DurationMinutes ?? 0)
                };
            })
            .OrderByDescending(u => u.GymVisits)
            .Take(20)
            .ToList();

        return new UserReportData
        {
            From = from,
            To = to,
            TotalUsers = totalUsers,
            NewUsersInPeriod = newUsersInPeriod,
            ActiveUsersInPeriod = activeUserIds,
            RetentionRate = Math.Round(retentionRate, 2),
            MonthlyRegistrations = monthlyRegistrations,
            MostActiveUsers = mostActiveUsers
        };
    }

    public async Task<AppointmentReportData> GetAppointmentReportAsync(DateTime from, DateTime to)
    {
        var appointments = await _context.Appointments
            .Include(a => a.Staff)
            .Where(a => a.CreatedAt >= from && a.CreatedAt <= to)
            .ToListAsync();

        var totalAppointments = appointments.Count;
        var completedAppointments = appointments.Count(a => a.Status == AppointmentStatus.Completed);
        var cancelledAppointments = appointments.Count(a => a.Status == AppointmentStatus.Cancelled);
        var cancellationRate = totalAppointments > 0
            ? (double)cancelledAppointments / totalAppointments * 100
            : 0;

        var staffBookings = appointments
            .GroupBy(a => new
            {
                a.StaffId,
                StaffName = $"{a.Staff.FirstName} {a.Staff.LastName}",
                StaffType = a.Staff.StaffType.ToString()
            })
            .Select(g => new StaffBookingItem
            {
                StaffName = g.Key.StaffName,
                StaffType = g.Key.StaffType,
                TotalBookings = g.Count(),
                CompletedBookings = g.Count(a => a.Status == AppointmentStatus.Completed),
                CancelledBookings = g.Count(a => a.Status == AppointmentStatus.Cancelled)
            })
            .OrderByDescending(s => s.TotalBookings)
            .ToList();

        var peakHours = appointments
            .GroupBy(a => a.ScheduledAt.Hour)
            .Select(g => new PeakHourItem
            {
                Hour = g.Key,
                AppointmentCount = g.Count()
            })
            .OrderByDescending(p => p.AppointmentCount)
            .ToList();

        var monthlyAppointments = appointments
            .GroupBy(a => new { a.CreatedAt.Year, a.CreatedAt.Month })
            .Select(g => new MonthlyAppointmentItem
            {
                Month = BosnianMonths[g.Key.Month - 1],
                Year = g.Key.Year,
                Count = g.Count(),
                CancelledCount = g.Count(a => a.Status == AppointmentStatus.Cancelled)
            })
            .OrderBy(m => m.Year).ThenBy(m => Array.IndexOf(BosnianMonths, m.Month))
            .ToList();

        return new AppointmentReportData
        {
            From = from,
            To = to,
            TotalAppointments = totalAppointments,
            CompletedAppointments = completedAppointments,
            CancelledAppointments = cancelledAppointments,
            CancellationRate = Math.Round(cancellationRate, 2),
            StaffBookings = staffBookings,
            PeakHours = peakHours,
            MonthlyAppointments = monthlyAppointments
        };
    }

    public async Task<GamificationReportData> GetGamificationReportAsync(DateTime from, DateTime to)
    {
        var gymVisits = await _context.GymVisits
            .Where(gv => gv.CheckInAt >= from && gv.CheckInAt <= to)
            .ToListAsync();

        var totalGymVisits = gymVisits.Count;
        var completedVisits = gymVisits.Where(gv => gv.DurationMinutes.HasValue).ToList();
        var avgVisitDuration = completedVisits.Count > 0
            ? completedVisits.Average(gv => gv.DurationMinutes!.Value)
            : 0;

        var levels = await _context.Levels.OrderBy(l => l.MinXP).ToListAsync();
        var users = await _context.Users
            .Where(u => u.Role == Role.User)
            .ToListAsync();

        var levelDistribution = levels
            .Select(l => new LevelDistributionItem
            {
                LevelName = l.Name,
                UserCount = users.Count(u => u.XP >= l.MinXP && u.XP <= l.MaxXP)
            })
            .Where(ld => ld.UserCount > 0)
            .ToList();

        var topUsers = users
            .OrderByDescending(u => u.XP)
            .Take(20)
            .Select(u => new LeaderboardSummaryItem
            {
                FullName = $"{u.FirstName} {u.LastName}",
                Email = u.Email,
                Level = u.Level,
                XP = u.XP,
                TotalGymMinutes = u.TotalGymMinutes
            })
            .ToList();

        var dailyVisits = gymVisits
            .GroupBy(gv => gv.CheckInAt.Date)
            .Select(g => new DailyVisitItem
            {
                Date = g.Key,
                VisitCount = g.Count(),
                AvgDurationMinutes = g.Where(gv => gv.DurationMinutes.HasValue).Any()
                    ? Math.Round(g.Where(gv => gv.DurationMinutes.HasValue).Average(gv => gv.DurationMinutes!.Value), 1)
                    : 0
            })
            .OrderBy(d => d.Date)
            .ToList();

        return new GamificationReportData
        {
            From = from,
            To = to,
            TotalGymVisits = totalGymVisits,
            AvgVisitDurationMinutes = Math.Round(avgVisitDuration, 1),
            LevelDistribution = levelDistribution,
            TopUsers = topUsers,
            DailyVisits = dailyVisits
        };
    }
}
