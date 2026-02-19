using System.Linq.Expressions;
using Microsoft.EntityFrameworkCore;
using GroundZero.Application.Common.Interfaces;
using GroundZero.Application.Common.Models;
using GroundZero.Application.Features.Products.Filters;
using GroundZero.Application.Querying;
using GroundZero.Domain.Entities;

namespace GroundZero.Infrastructure.Persistence.Repositories;

public class ProductRepository : IProductRepository
{
    private readonly AppDbContext _ctx;
    public ProductRepository(AppDbContext ctx) => _ctx = ctx;

    public async Task<Product?> GetByIdAsync(Guid id, CancellationToken ct = default) => await _ctx.Products.FindAsync([id], ct);

    public async Task<PagedResult<Product>> GetPagedAsync(ProductFilter f, CancellationToken ct = default)
    {
        var q = _ctx.Products.AsNoTracking().AsQueryable();
        if (!string.IsNullOrWhiteSpace(f.SearchTerm))
        { var t = f.SearchTerm.ToLower(); q = q.Where(p => p.Name.ToLower().Contains(t) || (p.Description != null && p.Description.ToLower().Contains(t))); }
        if (f.Status.HasValue) q = q.Where(p => p.Status == f.Status.Value);
        if (f.MinPrice.HasValue) q = q.Where(p => p.Price >= f.MinPrice.Value);
        if (f.MaxPrice.HasValue) q = q.Where(p => p.Price <= f.MaxPrice.Value);
        var map = new Dictionary<string, Expression<Func<Product, object>>>
        { ["name"] = p => p.Name, ["price"] = p => p.Price, ["createdat"] = p => p.CreatedAt, ["status"] = p => p.Status };
        q = q.ApplySort(f.SortBy, f.SortDescending, map);
        if (string.IsNullOrWhiteSpace(f.SortBy)) q = q.OrderByDescending(p => p.CreatedAt);
        return await q.ToPagedResultAsync(f.Page, f.PageSize, ct);
    }

    public async Task<List<Product>> GetAllAsync(CancellationToken ct = default) => await _ctx.Products.AsNoTracking().ToListAsync(ct);
    public async Task AddAsync(Product p, CancellationToken ct = default) => await _ctx.Products.AddAsync(p, ct);
    public void Update(Product p) => _ctx.Products.Update(p);
    public void Delete(Product p) => _ctx.Products.Remove(p);
    public async Task<bool> ExistsAsync(Guid id, CancellationToken ct = default) => await _ctx.Products.AnyAsync(p => p.Id == id, ct);
    public async Task SaveChangesAsync(CancellationToken ct = default) => await _ctx.SaveChangesAsync(ct);
}