using GroundZero.Application.Common;
using MediatR;

namespace GroundZero.Application.Features.Products.Commands;

[AuthorizeRole("Admin")]
public class DeleteProductCommand : IRequest<Unit>
{
    public int Id { get; set; }
}
