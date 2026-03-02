using GroundZero.Application.Common;
using GroundZero.Application.Features.Orders.DTOs;
using MediatR;

namespace GroundZero.Application.Features.Orders.Commands;

[AuthorizeRole("User")]
public class CreateOrderCommand : IRequest<OrderResponse>
{
    public CreateOrderRequest Request { get; set; } = null!;
}
