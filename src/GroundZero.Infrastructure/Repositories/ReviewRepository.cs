using GroundZero.Application.Common;
using GroundZero.Application.IRepositories;
using GroundZero.Domain.Entities;
using GroundZero.Domain.Enums;
using GroundZero.Infrastructure.Data;
using Microsoft.EntityFrameworkCore;

namespace GroundZero.Infrastructure.Repositories;

public class ReviewRepository : Repository<Review>, IReviewRepository
{
    public ReviewRepository(ApplicationDbContext context) : base(context) { }

    public async Task<Review?> GetByIdWithDetailsAsync(int id, CancellationToken cancellationToken = default)
    {
        return await _dbSet
            .Include(r => r.User)
            .Include(r => r.Product)
            .Include(r => r.Appointment)
                .ThenInclude(a => a!.Staff)
            .FirstOrDefaultAsync(r => r.Id == id, cancellationToken);
    }

    public async Task<PagedResult<Review>> GetProductReviewsPagedAsync(
        int productId, int pageNumber, int pageSize, CancellationToken cancellationToken = default)
    {
        var query = _dbSet
            .Include(r => r.User)
            .Include(r => r.Product)
            .Where(r => r.ReviewType == ReviewType.Product && r.ProductId == productId);

        var totalCount = await query.CountAsync(cancellationToken);

        var items = await query
            .OrderByDescending(r => r.CreatedAt)
            .Skip((pageNumber - 1) * pageSize)
            .Take(pageSize)
            .ToListAsync(cancellationToken);

        return new PagedResult<Review>
        {
            Items = items,
            TotalCount = totalCount,
            PageNumber = pageNumber,
            PageSize = pageSize
        };
    }

    public async Task<PagedResult<Review>> GetStaffReviewsPagedAsync(
        int staffId, int pageNumber, int pageSize, CancellationToken cancellationToken = default)
    {
        var query = _dbSet
            .Include(r => r.User)
            .Include(r => r.Appointment)
                .ThenInclude(a => a!.Staff)
            .Where(r => r.ReviewType == ReviewType.Appointment && r.Appointment!.StaffId == staffId);

        var totalCount = await query.CountAsync(cancellationToken);

        var items = await query
            .OrderByDescending(r => r.CreatedAt)
            .Skip((pageNumber - 1) * pageSize)
            .Take(pageSize)
            .ToListAsync(cancellationToken);

        return new PagedResult<Review>
        {
            Items = items,
            TotalCount = totalCount,
            PageNumber = pageNumber,
            PageSize = pageSize
        };
    }

    public async Task<bool> HasUserReviewedProductAsync(int userId, int productId, CancellationToken cancellationToken = default)
    {
        return await _dbSet.AnyAsync(
            r => r.UserId == userId && r.ProductId == productId && r.ReviewType == ReviewType.Product,
            cancellationToken);
    }

    public async Task<bool> HasUserReviewedAppointmentAsync(int userId, int appointmentId, CancellationToken cancellationToken = default)
    {
        return await _dbSet.AnyAsync(
            r => r.UserId == userId && r.AppointmentId == appointmentId && r.ReviewType == ReviewType.Appointment,
            cancellationToken);
    }

    public async Task<double?> GetAverageRatingForProductAsync(int productId, CancellationToken cancellationToken = default)
    {
        var query = _dbSet.Where(r => r.ReviewType == ReviewType.Product && r.ProductId == productId);

        if (!await query.AnyAsync(cancellationToken))
            return null;

        return await query.AverageAsync(r => r.Rating, cancellationToken);
    }

    public async Task<double?> GetAverageRatingForStaffAsync(int staffId, CancellationToken cancellationToken = default)
    {
        var query = _dbSet.Where(r => r.ReviewType == ReviewType.Appointment && r.Appointment!.StaffId == staffId);

        if (!await query.AnyAsync(cancellationToken))
            return null;

        return await query.AverageAsync(r => r.Rating, cancellationToken);
    }
}
