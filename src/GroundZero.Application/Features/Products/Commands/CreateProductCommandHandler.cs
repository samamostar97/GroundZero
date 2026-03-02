using GroundZero.Application.Exceptions;
using GroundZero.Application.Features.Products.DTOs;
using GroundZero.Application.IRepositories;
using GroundZero.Domain.Entities;
using MediatR;

namespace GroundZero.Application.Features.Products.Commands;

public class CreateProductCommandHandler : IRequestHandler<CreateProductCommand, ProductResponse>
{
    private readonly IProductRepository _productRepository;
    private readonly ICategoryRepository _categoryRepository;

    public CreateProductCommandHandler(IProductRepository productRepository, ICategoryRepository categoryRepository)
    {
        _productRepository = productRepository;
        _categoryRepository = categoryRepository;
    }

    public async Task<ProductResponse> Handle(CreateProductCommand command, CancellationToken cancellationToken)
    {
        var category = await _categoryRepository.GetByIdAsync(command.Request.CategoryId, cancellationToken)
            ?? throw new NotFoundException("Kategorija", command.Request.CategoryId);

        var product = new Product
        {
            Name = command.Request.Name,
            Description = command.Request.Description,
            Price = command.Request.Price,
            StockQuantity = command.Request.StockQuantity,
            CategoryId = command.Request.CategoryId
        };

        await _productRepository.AddAsync(product, cancellationToken);
        await _productRepository.SaveChangesAsync(cancellationToken);

        product.Category = category;
        return product.ToResponse();
    }
}
