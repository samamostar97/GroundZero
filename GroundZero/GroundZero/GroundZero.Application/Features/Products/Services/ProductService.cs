using GroundZero.Application.Common.Exceptions;
using GroundZero.Application.Common.Interfaces;
using GroundZero.Application.Common.Models;
using GroundZero.Application.Features.Products.Dtos;
using GroundZero.Application.Features.Products.Filters;
using GroundZero.Domain.Entities;

namespace GroundZero.Application.Features.Products.Services;

public class ProductService : IProductService
{
    private readonly IProductRepository _repo;
    public ProductService(IProductRepository repo) => _repo = repo;

    public async Task<ProductDto?> GetByIdAsync(Guid id, CancellationToken ct = default)
    {
        var p = await _repo.GetByIdAsync(id, ct) ?? throw new NotFoundException(nameof(Product), id);
        return MapToDto(p);
    }

    public async Task<PagedResult<ProductDto>> GetPagedAsync(ProductFilter filter, CancellationToken ct = default)
        => (await _repo.GetPagedAsync(filter, ct)).Map(MapToDto);

    public async Task<ProductDto> CreateAsync(CreateProductRequest req, CancellationToken ct = default)
    {
        var p = new Product { Name = req.Name, Description = req.Description, Price = req.Price,
            StockQuantity = req.StockQuantity, ImageUrl = req.ImageUrl, Status = req.Status };
        await _repo.AddAsync(p, ct); await _repo.SaveChangesAsync(ct);
        return MapToDto(p);
    }

    public async Task<ProductDto> UpdateAsync(Guid id, UpdateProductRequest req, CancellationToken ct = default)
    {
        var p = await _repo.GetByIdAsync(id, ct) ?? throw new NotFoundException(nameof(Product), id);
        p.Name = req.Name; p.Description = req.Description; p.Price = req.Price;
        p.StockQuantity = req.StockQuantity; p.ImageUrl = req.ImageUrl; p.Status = req.Status;
        p.UpdatedAt = DateTime.UtcNow;
        _repo.Update(p); await _repo.SaveChangesAsync(ct);
        return MapToDto(p);
    }

    public async Task DeleteAsync(Guid id, CancellationToken ct = default)
    {
        var p = await _repo.GetByIdAsync(id, ct) ?? throw new NotFoundException(nameof(Product), id);
        _repo.Delete(p); await _repo.SaveChangesAsync(ct);
    }

    private static ProductDto MapToDto(Product p) => new()
    { Id = p.Id, Name = p.Name, Description = p.Description, Price = p.Price,
      StockQuantity = p.StockQuantity, ImageUrl = p.ImageUrl, Status = p.Status,
      CreatedAt = p.CreatedAt, UpdatedAt = p.UpdatedAt };
}