using GroundZero.Application.Common;
using GroundZero.Domain.Entities;
using GroundZero.Domain.Enums;

namespace GroundZero.Application.IRepositories;

public interface IAppointmentRepository : IRepository<Appointment>
{
    Task<Appointment?> GetByIdWithDetailsAsync(int id, CancellationToken cancellationToken = default);
    Task<PagedResult<Appointment>> GetUserAppointmentsPagedAsync(int userId, AppointmentStatus? status, int pageNumber, int pageSize, CancellationToken cancellationToken = default);
    Task<PagedResult<Appointment>> GetAllAppointmentsPagedAsync(string? search, AppointmentStatus? status, int? staffId, int? userId, string? sortBy, bool sortDescending, int pageNumber, int pageSize, CancellationToken cancellationToken = default);
    Task<bool> HasOverlappingAppointmentAsync(int staffId, DateTime scheduledAt, int durationMinutes, int? excludeId = null, CancellationToken cancellationToken = default);
    Task<List<Appointment>> GetStaffAppointmentsForDateAsync(int staffId, DateTime date, CancellationToken cancellationToken = default);
}
