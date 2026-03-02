using GroundZero.Domain.Enums;

namespace GroundZero.Application.Features.Orders.DTOs;

public class UpdateOrderStatusRequest
{
    public OrderStatus Status { get; set; }
}
