using GroundZero.Application.Common;
using MediatR;

namespace GroundZero.Application.Features.Products.Commands;

public class DeleteProductCommand : IRequest<ApiResponse<string>>
{
    public int Id { get; set; }
}
