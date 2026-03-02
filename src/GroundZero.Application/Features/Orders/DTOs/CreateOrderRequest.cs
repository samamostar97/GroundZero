namespace GroundZero.Application.Features.Orders.DTOs;

public class CreateOrderRequest
{
    public List<OrderItemRequest> Items { get; set; } = new();
}
