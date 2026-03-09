using GroundZero.Application.Features.Dashboard.DTOs;
using GroundZero.Application.IRepositories;
using GroundZero.Domain.Enums;
using GroundZero.Infrastructure.Data;
using Microsoft.EntityFrameworkCore;

namespace GroundZero.Infrastructure.Repositories;

public class DashboardRepository : IDashboardRepository
{
    private readonly ApplicationDbContext _context;

    public DashboardRepository(ApplicationDbContext context)
    {
        _context = context;
    }

    public async Task<DashboardResponse> GetDashboardDataAsync(CancellationToken cancellationToken = default)
    {
        // Active gym visits (checked in, not yet checked out)
        var activeVisits = await _context.GymVisits
            .Where(gv => gv.CheckOutAt == null)
            .Include(gv => gv.User)
            .OrderBy(gv => gv.CheckInAt)
            .Select(gv => new ActiveGymVisitItem
            {
                Id = gv.Id,
                UserId = gv.UserId,
                UserFullName = gv.User.FirstName + " " + gv.User.LastName,
                CheckInAt = gv.CheckInAt
            })
            .ToListAsync(cancellationToken);

        // Pending orders
        var pendingOrders = await _context.Orders
            .Where(o => o.Status == OrderStatus.Pending)
            .Include(o => o.User)
            .Include(o => o.Items)
            .OrderByDescending(o => o.CreatedAt)
            .Select(o => new PendingOrderItem
            {
                Id = o.Id,
                UserId = o.UserId,
                UserFullName = o.User.FirstName + " " + o.User.LastName,
                TotalAmount = o.TotalAmount,
                ItemCount = o.Items.Sum(i => i.Quantity),
                CreatedAt = o.CreatedAt
            })
            .ToListAsync(cancellationToken);

        // Pending appointments count
        var pendingAppointmentCount = await _context.Appointments
            .CountAsync(a => a.Status == AppointmentStatus.Pending, cancellationToken);

        // Low stock products (stock < 5)
        var lowStockProductCount = await _context.Products
            .CountAsync(p => p.StockQuantity < 5, cancellationToken);

        // New users this month
        var firstOfMonth = new DateTime(DateTime.UtcNow.Year, DateTime.UtcNow.Month, 1);
        var newUsersThisMonth = await _context.Users
            .CountAsync(u => u.Role == Role.User && u.CreatedAt >= firstOfMonth, cancellationToken);

        return new DashboardResponse
        {
            CurrentlyInGym = activeVisits.Count,
            LowStockProductCount = lowStockProductCount,
            PendingAppointmentCount = pendingAppointmentCount,
            NewUsersThisMonth = newUsersThisMonth,
            ActiveGymVisits = activeVisits,
            PendingOrders = pendingOrders
        };
    }

    public async Task<List<ActivityFeedItemResponse>> GetActivityFeedAsync(int count = 20, CancellationToken cancellationToken = default)
    {
        var feed = new List<ActivityFeedItemResponse>();

        // Recent check-ins (last 7 days)
        var recentCheckIns = await _context.GymVisits
            .Where(gv => gv.CheckInAt >= DateTime.UtcNow.AddDays(-7))
            .Include(gv => gv.User)
            .Select(gv => new { gv.User.FirstName, gv.User.LastName, gv.CheckInAt, gv.CheckOutAt })
            .ToListAsync(cancellationToken);

        foreach (var visit in recentCheckIns)
        {
            feed.Add(new ActivityFeedItemResponse
            {
                Type = "CheckIn",
                Message = $"{visit.FirstName} {visit.LastName} se prijavio/la u teretanu.",
                Timestamp = visit.CheckInAt
            });

            if (visit.CheckOutAt.HasValue)
            {
                feed.Add(new ActivityFeedItemResponse
                {
                    Type = "CheckOut",
                    Message = $"{visit.FirstName} {visit.LastName} se odjavio/la iz teretane.",
                    Timestamp = visit.CheckOutAt.Value
                });
            }
        }

        // Recent orders (last 7 days)
        var recentOrders = await _context.Orders
            .Where(o => o.CreatedAt >= DateTime.UtcNow.AddDays(-7))
            .Include(o => o.User)
            .Select(o => new { o.User.FirstName, o.User.LastName, o.Id, o.TotalAmount, o.CreatedAt })
            .ToListAsync(cancellationToken);

        foreach (var order in recentOrders)
        {
            feed.Add(new ActivityFeedItemResponse
            {
                Type = "Order",
                Message = $"Nova narudžba #{order.Id} — {order.FirstName} {order.LastName} ({order.TotalAmount:F2} KM)",
                Timestamp = order.CreatedAt
            });
        }

        // Recent appointments (last 7 days)
        var recentAppointments = await _context.Appointments
            .Where(a => a.CreatedAt >= DateTime.UtcNow.AddDays(-7))
            .Include(a => a.User)
            .Include(a => a.Staff)
            .Select(a => new { a.User.FirstName, a.User.LastName, StaffName = a.Staff.FirstName + " " + a.Staff.LastName, a.CreatedAt })
            .ToListAsync(cancellationToken);

        foreach (var apt in recentAppointments)
        {
            feed.Add(new ActivityFeedItemResponse
            {
                Type = "Appointment",
                Message = $"Novi termin — {apt.FirstName} {apt.LastName} sa {apt.StaffName}",
                Timestamp = apt.CreatedAt
            });
        }

        // Recent registrations (last 7 days)
        var recentUsers = await _context.Users
            .Where(u => u.Role == Role.User && u.CreatedAt >= DateTime.UtcNow.AddDays(-7))
            .Select(u => new { u.FirstName, u.LastName, u.CreatedAt })
            .ToListAsync(cancellationToken);

        foreach (var user in recentUsers)
        {
            feed.Add(new ActivityFeedItemResponse
            {
                Type = "Registration",
                Message = $"Novi korisnik — {user.FirstName} {user.LastName} se registrovao/la.",
                Timestamp = user.CreatedAt
            });
        }

        return feed
            .OrderByDescending(f => f.Timestamp)
            .Take(count)
            .ToList();
    }
}
