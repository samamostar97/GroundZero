using GroundZero.Domain.Entities;

namespace GroundZero.Application.IRepositories;

public interface IRecommendationRepository
{
    Task<List<(Product Product, int CoPurchaseCount)>> GetProductRecommendationsAsync(
        int productId, int limit, CancellationToken cancellationToken = default);

    Task<List<(Product Product, int CoPurchaseCount)>> GetUserRecommendationsAsync(
        int userId, int limit, CancellationToken cancellationToken = default);
}
