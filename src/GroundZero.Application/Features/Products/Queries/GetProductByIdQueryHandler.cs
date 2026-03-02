using GroundZero.Application.Exceptions;
using GroundZero.Application.Features.Products.DTOs;
using GroundZero.Application.IRepositories;
using MediatR;

namespace GroundZero.Application.Features.Products.Queries;

public class GetProductByIdQueryHandler : IRequestHandler<GetProductByIdQuery, ProductResponse>
{
    private readonly IProductRepository _productRepository;

    public GetProductByIdQueryHandler(IProductRepository productRepository)
    {
        _productRepository = productRepository;
    }

    public async Task<ProductResponse> Handle(GetProductByIdQuery query, CancellationToken cancellationToken)
    {
        var product = await _productRepository.GetByIdWithCategoryAsync(query.Id, cancellationToken)
            ?? throw new NotFoundException("Proizvod", query.Id);

        return product.ToResponse();
    }
}
