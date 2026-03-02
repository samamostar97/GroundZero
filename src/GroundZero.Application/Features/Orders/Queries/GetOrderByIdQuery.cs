using GroundZero.Application.Features.Orders.DTOs;
using MediatR;

namespace GroundZero.Application.Features.Orders.Queries;

public class GetOrderByIdQuery : IRequest<OrderResponse>
{
    public int Id { get; set; }
}
