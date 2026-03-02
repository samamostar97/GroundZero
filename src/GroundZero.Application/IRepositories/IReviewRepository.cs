using GroundZero.Application.Common;
using GroundZero.Domain.Entities;

namespace GroundZero.Application.IRepositories;

public interface IReviewRepository : IRepository<Review>
{
    Task<Review?> GetByIdWithDetailsAsync(int id, CancellationToken cancellationToken = default);
    Task<PagedResult<Review>> GetProductReviewsPagedAsync(int productId, int pageNumber, int pageSize, CancellationToken cancellationToken = default);
    Task<PagedResult<Review>> GetStaffReviewsPagedAsync(int staffId, int pageNumber, int pageSize, CancellationToken cancellationToken = default);
    Task<bool> HasUserReviewedProductAsync(int userId, int productId, CancellationToken cancellationToken = default);
    Task<bool> HasUserReviewedAppointmentAsync(int userId, int appointmentId, CancellationToken cancellationToken = default);
    Task<double?> GetAverageRatingForProductAsync(int productId, CancellationToken cancellationToken = default);
    Task<double?> GetAverageRatingForStaffAsync(int staffId, CancellationToken cancellationToken = default);
}
