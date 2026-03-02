using GroundZero.Application.Common;
using GroundZero.Application.Features.Products.DTOs;
using MediatR;

namespace GroundZero.Application.Features.Products.Commands;

[AuthorizeRole("Admin")]
public class UpdateProductCommand : IRequest<ProductResponse>
{
    public int Id { get; set; }
    public UpdateProductRequest Request { get; set; } = null!;
}
