using GroundZero.Application.Common;
using GroundZero.Application.Features.Orders.DTOs;
using GroundZero.Domain.Enums;
using MediatR;

namespace GroundZero.Application.Features.Orders.Commands;

[AuthorizeRole("Admin")]
public class UpdateOrderStatusCommand : IRequest<OrderResponse>
{
    public int Id { get; set; }
    public UpdateOrderStatusRequest Request { get; set; } = null!;
}
