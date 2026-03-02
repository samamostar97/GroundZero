using GroundZero.Application.Features.Products.DTOs;
using MediatR;

namespace GroundZero.Application.Features.Products.Queries;

public class GetProductByIdQuery : IRequest<ProductResponse>
{
    public int Id { get; set; }
}
