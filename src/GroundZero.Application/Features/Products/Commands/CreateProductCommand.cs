using GroundZero.Application.Common;
using GroundZero.Application.Features.Products.DTOs;
using MediatR;

namespace GroundZero.Application.Features.Products.Commands;

[AuthorizeRole("Admin")]
public class CreateProductCommand : IRequest<ProductResponse>
{
    public CreateProductRequest Request { get; set; } = null!;
}
