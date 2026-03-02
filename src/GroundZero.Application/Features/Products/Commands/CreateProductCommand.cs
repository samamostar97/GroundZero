using GroundZero.Application.Common;
using GroundZero.Application.Features.Products.DTOs;
using MediatR;

namespace GroundZero.Application.Features.Products.Commands;

public class CreateProductCommand : IRequest<ApiResponse<ProductResponse>>
{
    public CreateProductRequest Request { get; set; } = null!;
}
