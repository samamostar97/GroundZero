using GroundZero.Application.Common;
using GroundZero.Application.Exceptions;
using GroundZero.Application.Features.Products.DTOs;
using GroundZero.Application.IRepositories;
using MediatR;

namespace GroundZero.Application.Features.Products.Commands;

public class UpdateProductCommandHandler : IRequestHandler<UpdateProductCommand, ApiResponse<ProductResponse>>
{
    private readonly IProductRepository _productRepository;
    private readonly ICategoryRepository _categoryRepository;

    public UpdateProductCommandHandler(IProductRepository productRepository, ICategoryRepository categoryRepository)
    {
        _productRepository = productRepository;
        _categoryRepository = categoryRepository;
    }

    public async Task<ApiResponse<ProductResponse>> Handle(UpdateProductCommand command, CancellationToken cancellationToken)
    {
        var product = await _productRepository.GetByIdWithCategoryAsync(command.Id, cancellationToken)
            ?? throw new NotFoundException("Proizvod", command.Id);

        var category = await _categoryRepository.GetByIdAsync(command.Request.CategoryId, cancellationToken)
            ?? throw new NotFoundException("Kategorija", command.Request.CategoryId);

        product.Name = command.Request.Name;
        product.Description = command.Request.Description;
        product.Price = command.Request.Price;
        product.StockQuantity = command.Request.StockQuantity;
        product.CategoryId = command.Request.CategoryId;
        product.Category = category;

        _productRepository.Update(product);
        await _productRepository.SaveChangesAsync(cancellationToken);

        return ApiResponse<ProductResponse>.Success(product.ToResponse());
    }
}
