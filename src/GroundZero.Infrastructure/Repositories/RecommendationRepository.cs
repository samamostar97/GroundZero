using GroundZero.Application.IRepositories;
using GroundZero.Domain.Entities;
using GroundZero.Domain.Enums;
using GroundZero.Infrastructure.Data;
using Microsoft.EntityFrameworkCore;

namespace GroundZero.Infrastructure.Repositories;

public class RecommendationRepository : IRecommendationRepository
{
    private readonly ApplicationDbContext _context;

    private static readonly OrderStatus[] ValidStatuses =
        { OrderStatus.Confirmed, OrderStatus.Shipped, OrderStatus.Delivered };

    public RecommendationRepository(ApplicationDbContext context)
    {
        _context = context;
    }

    public async Task<List<(Product Product, int CoPurchaseCount)>> GetProductRecommendationsAsync(
        int productId, int limit, CancellationToken cancellationToken = default)
    {
        // 1. Find all orders containing the given product (valid statuses only)
        var orderIds = await _context.OrderItems
            .Where(oi => oi.ProductId == productId)
            .Select(oi => oi.OrderId)
            .Distinct()
            .Where(orderId => _context.Orders
                .Any(o => o.Id == orderId && ValidStatuses.Contains(o.Status)))
            .ToListAsync(cancellationToken);

        if (orderIds.Count == 0)
            return new List<(Product, int)>();

        // 2. From those orders, get all OTHER products grouped by frequency
        var recommendations = await _context.OrderItems
            .Where(oi => orderIds.Contains(oi.OrderId) && oi.ProductId != productId)
            .GroupBy(oi => oi.ProductId)
            .Select(g => new
            {
                ProductId = g.Key,
                CoPurchaseCount = g.Select(oi => oi.OrderId).Distinct().Count()
            })
            .OrderByDescending(x => x.CoPurchaseCount)
            .Take(limit)
            .ToListAsync(cancellationToken);

        if (recommendations.Count == 0)
            return new List<(Product, int)>();

        // 3. Load product entities with categories, filter out-of-stock
        var productIds = recommendations.Select(r => r.ProductId).ToList();

        var products = await _context.Products
            .Include(p => p.Category)
            .Where(p => productIds.Contains(p.Id) && p.StockQuantity > 0)
            .ToListAsync(cancellationToken);

        // 4. Join back with co-purchase counts, maintain frequency ordering
        var productDict = products.ToDictionary(p => p.Id);

        return recommendations
            .Where(r => productDict.ContainsKey(r.ProductId))
            .Select(r => (productDict[r.ProductId], r.CoPurchaseCount))
            .ToList();
    }

    public async Task<List<(Product Product, int CoPurchaseCount)>> GetUserRecommendationsAsync(
        int userId, int limit, CancellationToken cancellationToken = default)
    {
        // 1. Find all products the user has purchased (valid orders)
        var userProductIds = await _context.OrderItems
            .Where(oi => _context.Orders
                .Any(o => o.Id == oi.OrderId && o.UserId == userId && ValidStatuses.Contains(o.Status)))
            .Select(oi => oi.ProductId)
            .Distinct()
            .ToListAsync(cancellationToken);

        if (userProductIds.Count == 0)
            return new List<(Product, int)>();

        // 2. Find all orders containing any of the user's purchased products
        var relatedOrderIds = await _context.OrderItems
            .Where(oi => userProductIds.Contains(oi.ProductId))
            .Select(oi => oi.OrderId)
            .Distinct()
            .Where(orderId => _context.Orders
                .Any(o => o.Id == orderId && ValidStatuses.Contains(o.Status)))
            .ToListAsync(cancellationToken);

        if (relatedOrderIds.Count == 0)
            return new List<(Product, int)>();

        // 3. From those orders, get co-purchased products (excluding user's already-purchased)
        var recommendations = await _context.OrderItems
            .Where(oi => relatedOrderIds.Contains(oi.OrderId) && !userProductIds.Contains(oi.ProductId))
            .GroupBy(oi => oi.ProductId)
            .Select(g => new
            {
                ProductId = g.Key,
                CoPurchaseCount = g.Select(oi => oi.OrderId).Distinct().Count()
            })
            .OrderByDescending(x => x.CoPurchaseCount)
            .Take(limit)
            .ToListAsync(cancellationToken);

        if (recommendations.Count == 0)
            return new List<(Product, int)>();

        // 4. Load product entities with categories, filter out-of-stock
        var productIds = recommendations.Select(r => r.ProductId).ToList();

        var products = await _context.Products
            .Include(p => p.Category)
            .Where(p => productIds.Contains(p.Id) && p.StockQuantity > 0)
            .ToListAsync(cancellationToken);

        // 5. Join back with co-purchase counts, maintain frequency ordering
        var productDict = products.ToDictionary(p => p.Id);

        return recommendations
            .Where(r => productDict.ContainsKey(r.ProductId))
            .Select(r => (productDict[r.ProductId], r.CoPurchaseCount))
            .ToList();
    }
}
