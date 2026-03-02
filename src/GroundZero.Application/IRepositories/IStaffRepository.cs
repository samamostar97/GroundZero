using GroundZero.Application.Common;
using GroundZero.Domain.Entities;
using GroundZero.Domain.Enums;

namespace GroundZero.Application.IRepositories;

public interface IStaffRepository : IRepository<Staff>
{
    Task<bool> EmailExistsAsync(string email, int? excludeId = null, CancellationToken cancellationToken = default);
    Task<PagedResult<Staff>> GetPagedAsync(string? search, StaffType? staffType, int pageNumber, int pageSize, CancellationToken cancellationToken = default);
}
