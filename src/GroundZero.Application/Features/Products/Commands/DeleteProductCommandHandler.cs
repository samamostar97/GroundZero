using GroundZero.Application.Common;
using GroundZero.Application.Exceptions;
using GroundZero.Application.IRepositories;
using MediatR;

namespace GroundZero.Application.Features.Products.Commands;

public class DeleteProductCommandHandler : IRequestHandler<DeleteProductCommand, ApiResponse<string>>
{
    private readonly IProductRepository _productRepository;

    public DeleteProductCommandHandler(IProductRepository productRepository)
    {
        _productRepository = productRepository;
    }

    public async Task<ApiResponse<string>> Handle(DeleteProductCommand command, CancellationToken cancellationToken)
    {
        var product = await _productRepository.GetByIdAsync(command.Id, cancellationToken)
            ?? throw new NotFoundException("Proizvod", command.Id);

        _productRepository.SoftDelete(product);
        await _productRepository.SaveChangesAsync(cancellationToken);

        return ApiResponse<string>.Success("Proizvod je uspješno obrisan.");
    }
}
