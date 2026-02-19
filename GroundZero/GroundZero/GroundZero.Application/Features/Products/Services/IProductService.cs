using GroundZero.Application.Common.Models;
using GroundZero.Application.Features.Products.Dtos;
using GroundZero.Application.Features.Products.Filters;
namespace GroundZero.Application.Features.Products.Services;
public interface IProductService
{
    Task<ProductDto?> GetByIdAsync(Guid id, CancellationToken ct = default);
    Task<PagedResult<ProductDto>> GetPagedAsync(ProductFilter filter, CancellationToken ct = default);
    Task<ProductDto> CreateAsync(CreateProductRequest request, CancellationToken ct = default);
    Task<ProductDto> UpdateAsync(Guid id, UpdateProductRequest request, CancellationToken ct = default);
    Task DeleteAsync(Guid id, CancellationToken ct = default);
}