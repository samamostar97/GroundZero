using GroundZero.Application.Common;
using GroundZero.Application.Features.Products.DTOs;
using GroundZero.Application.IRepositories;
using MediatR;

namespace GroundZero.Application.Features.Products.Queries;

public class GetAllProductsQueryHandler : IRequestHandler<GetAllProductsQuery, PagedResult<ProductResponse>>
{
    private readonly IProductRepository _productRepository;

    public GetAllProductsQueryHandler(IProductRepository productRepository)
    {
        _productRepository = productRepository;
    }

    public async Task<PagedResult<ProductResponse>> Handle(GetAllProductsQuery query, CancellationToken cancellationToken)
    {
        var paged = await _productRepository.GetPagedAsync(
            query.Search, query.CategoryId, query.MinPrice, query.MaxPrice,
            query.SortBy, query.SortDescending, query.PageNumber, query.PageSize, cancellationToken);

        var result = new PagedResult<ProductResponse>
        {
            Items = paged.Items.Select(p => p.ToResponse()).ToList(),
            TotalCount = paged.TotalCount,
            PageNumber = paged.PageNumber,
            PageSize = paged.PageSize
        };

        return result;
    }
}
