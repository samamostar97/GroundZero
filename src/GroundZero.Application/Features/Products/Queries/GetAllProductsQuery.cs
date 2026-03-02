using GroundZero.Application.Common;
using GroundZero.Application.Features.Products.DTOs;
using MediatR;

namespace GroundZero.Application.Features.Products.Queries;

public class GetAllProductsQuery : IRequest<PagedResult<ProductResponse>>
{
    public int PageNumber { get; set; } = 1;
    public int PageSize { get; set; } = 10;
    public string? Search { get; set; }
    public int? CategoryId { get; set; }
    public decimal? MinPrice { get; set; }
    public decimal? MaxPrice { get; set; }
}
