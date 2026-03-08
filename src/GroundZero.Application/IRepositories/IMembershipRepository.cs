using GroundZero.Application.Common;
using GroundZero.Domain.Entities;
using GroundZero.Domain.Enums;

namespace GroundZero.Application.IRepositories;

public interface IMembershipRepository : IRepository<UserMembership>
{
    Task<UserMembership?> GetByIdWithDetailsAsync(int id, CancellationToken cancellationToken = default);
    Task<UserMembership?> GetCurrentMembershipForUserAsync(int userId, CancellationToken cancellationToken = default);
    Task<PagedResult<UserMembership>> GetUserMembershipHistoryPagedAsync(int userId,
        int pageNumber, int pageSize, CancellationToken cancellationToken = default);
    Task<PagedResult<UserMembership>> GetAllMembershipsPagedAsync(string? search, MembershipStatus? status, int? userId,
        string? sortBy, bool sortDescending, int pageNumber, int pageSize, CancellationToken cancellationToken = default);
}
