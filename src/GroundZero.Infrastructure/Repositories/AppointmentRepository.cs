using GroundZero.Application.Common;
using GroundZero.Application.IRepositories;
using GroundZero.Domain.Entities;
using GroundZero.Domain.Enums;
using GroundZero.Infrastructure.Data;
using Microsoft.EntityFrameworkCore;

namespace GroundZero.Infrastructure.Repositories;

public class AppointmentRepository : Repository<Appointment>, IAppointmentRepository
{
    public AppointmentRepository(ApplicationDbContext context) : base(context) { }

    public async Task<Appointment?> GetByIdWithDetailsAsync(int id, CancellationToken cancellationToken = default)
    {
        return await _dbSet
            .Include(a => a.User)
            .Include(a => a.Staff)
            .FirstOrDefaultAsync(a => a.Id == id, cancellationToken);
    }

    public async Task<PagedResult<Appointment>> GetUserAppointmentsPagedAsync(
        int userId, AppointmentStatus? status, int pageNumber, int pageSize,
        CancellationToken cancellationToken = default)
    {
        var query = _dbSet
            .Include(a => a.User)
            .Include(a => a.Staff)
            .Where(a => a.UserId == userId);

        if (status.HasValue)
            query = query.Where(a => a.Status == status.Value);

        var totalCount = await query.CountAsync(cancellationToken);

        var items = await query
            .OrderByDescending(a => a.ScheduledAt)
            .Skip((pageNumber - 1) * pageSize)
            .Take(pageSize)
            .ToListAsync(cancellationToken);

        return new PagedResult<Appointment>
        {
            Items = items,
            TotalCount = totalCount,
            PageNumber = pageNumber,
            PageSize = pageSize
        };
    }

    public async Task<PagedResult<Appointment>> GetAllAppointmentsPagedAsync(
        string? search, AppointmentStatus? status, int? staffId, int? userId,
        string? sortBy, bool sortDescending, int pageNumber, int pageSize,
        string? excludeStatuses = null, CancellationToken cancellationToken = default)
    {
        var query = _dbSet
            .Include(a => a.User)
            .Include(a => a.Staff)
            .AsQueryable();

        if (!string.IsNullOrWhiteSpace(search))
        {
            var searchLower = search.ToLower();
            query = query.Where(a =>
                a.User.FirstName.ToLower().Contains(searchLower) ||
                a.User.LastName.ToLower().Contains(searchLower) ||
                a.Staff.FirstName.ToLower().Contains(searchLower) ||
                a.Staff.LastName.ToLower().Contains(searchLower));
        }

        if (status.HasValue)
            query = query.Where(a => a.Status == status.Value);

        if (staffId.HasValue)
            query = query.Where(a => a.StaffId == staffId.Value);

        if (userId.HasValue)
            query = query.Where(a => a.UserId == userId.Value);

        if (!string.IsNullOrWhiteSpace(excludeStatuses))
        {
            var excluded = excludeStatuses.Split(',')
                .Select(s => Enum.Parse<AppointmentStatus>(s.Trim()))
                .ToList();
            query = query.Where(a => !excluded.Contains(a.Status));
        }

        var totalCount = await query.CountAsync(cancellationToken);

        query = sortBy?.ToLower() switch
        {
            "id" => sortDescending ? query.OrderByDescending(a => a.Id) : query.OrderBy(a => a.Id),
            "userfullname" => sortDescending ? query.OrderByDescending(a => a.User.FirstName) : query.OrderBy(a => a.User.FirstName),
            "stafffullname" => sortDescending ? query.OrderByDescending(a => a.Staff.FirstName) : query.OrderBy(a => a.Staff.FirstName),
            "durationminutes" => sortDescending ? query.OrderByDescending(a => a.DurationMinutes) : query.OrderBy(a => a.DurationMinutes),
            _ => sortDescending ? query.OrderByDescending(a => a.ScheduledAt) : query.OrderBy(a => a.ScheduledAt),
        };

        var items = await query
            .Skip((pageNumber - 1) * pageSize)
            .Take(pageSize)
            .ToListAsync(cancellationToken);

        return new PagedResult<Appointment>
        {
            Items = items,
            TotalCount = totalCount,
            PageNumber = pageNumber,
            PageSize = pageSize
        };
    }

    public async Task<List<Appointment>> GetStaffAppointmentsForDateAsync(
        int staffId, DateTime date, CancellationToken cancellationToken = default)
    {
        var dayStart = date.Date;
        var dayEnd = dayStart.AddDays(1);

        return await _dbSet
            .Where(a => a.StaffId == staffId)
            .Where(a => a.Status != AppointmentStatus.Cancelled)
            .Where(a => a.ScheduledAt >= dayStart && a.ScheduledAt < dayEnd)
            .OrderBy(a => a.ScheduledAt)
            .ToListAsync(cancellationToken);
    }

    public async Task<bool> HasOverlappingAppointmentAsync(
        int staffId, DateTime scheduledAt, int durationMinutes, int? excludeId = null,
        CancellationToken cancellationToken = default)
    {
        var newStart = scheduledAt;
        var newEnd = scheduledAt.AddMinutes(durationMinutes);

        var query = _dbSet
            .Where(a => a.StaffId == staffId)
            .Where(a => a.Status != AppointmentStatus.Cancelled);

        if (excludeId.HasValue)
            query = query.Where(a => a.Id != excludeId.Value);

        return await query.AnyAsync(a =>
            a.ScheduledAt < newEnd &&
            newStart < a.ScheduledAt.AddMinutes(a.DurationMinutes),
            cancellationToken);
    }
}
