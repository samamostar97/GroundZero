using GroundZero.Domain.Enums;

namespace GroundZero.Application.Features.Orders.DTOs;

public class OrderResponse
{
    public int Id { get; set; }
    public int UserId { get; set; }
    public string UserFullName { get; set; } = string.Empty;
    public decimal TotalAmount { get; set; }
    public OrderStatus Status { get; set; }
    public string? StripePaymentIntentId { get; set; }
    public string? StripeClientSecret { get; set; }
    public List<OrderItemResponse> Items { get; set; } = new();
    public DateTime CreatedAt { get; set; }
}
