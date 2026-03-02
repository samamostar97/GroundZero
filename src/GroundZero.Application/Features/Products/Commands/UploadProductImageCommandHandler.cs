using GroundZero.Application.Common;
using GroundZero.Application.Exceptions;
using GroundZero.Application.Features.Products.DTOs;
using GroundZero.Application.IRepositories;
using GroundZero.Application.IServices;
using MediatR;

namespace GroundZero.Application.Features.Products.Commands;

public class UploadProductImageCommandHandler : IRequestHandler<UploadProductImageCommand, ProductResponse>
{
    private readonly IProductRepository _productRepository;
    private readonly IFileService _fileService;

    public UploadProductImageCommandHandler(IProductRepository productRepository, IFileService fileService)
    {
        _productRepository = productRepository;
        _fileService = fileService;
    }

    public async Task<ProductResponse> Handle(UploadProductImageCommand command, CancellationToken cancellationToken)
    {
        var product = await _productRepository.GetByIdWithCategoryAsync(command.Id, cancellationToken)
            ?? throw new NotFoundException("Proizvod", command.Id);

        if (command.FileStream is null)
            throw new ValidationException("Fajl je obavezan.");

        if (!string.IsNullOrEmpty(product.ImageUrl))
            _fileService.DeleteFile(product.ImageUrl);

        var imageUrl = await _fileService.UploadFileAsync(command.FileStream, command.FileName, "products");
        product.ImageUrl = imageUrl;

        _productRepository.Update(product);
        await _productRepository.SaveChangesAsync(cancellationToken);

        return product.ToResponse();
    }
}
