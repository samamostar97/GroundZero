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

        // New users this month
        var firstOfMonth = new DateTime(DateTime.UtcNow.Year, DateTime.UtcNow.Month, 1);
        var newUsersThisMonth = await _context.Users
            .CountAsync(u => u.Role == Role.User && u.CreatedAt >= firstOfMonth, cancellationToken);

        return new DashboardResponse
        {
            CurrentlyInGym = activeVisits.Count,
            PendingOrderCount = pendingOrders.Count,
            PendingAppointmentCount = pendingAppointmentCount,
            NewUsersThisMonth = newUsersThisMonth,
            ActiveGymVisits = activeVisits,
            PendingOrders = pendingOrders
        };
    }
}
