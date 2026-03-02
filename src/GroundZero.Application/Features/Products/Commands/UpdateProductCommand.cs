using GroundZero.Application.Common;
using GroundZero.Application.Features.Products.DTOs;
using MediatR;

namespace GroundZero.Application.Features.Products.Commands;

public class UpdateProductCommand : IRequest<ApiResponse<ProductResponse>>
{
    public int Id { get; set; }
    public UpdateProductRequest Request { get; set; } = null!;
}
