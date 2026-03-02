using GroundZero.Domain.Entities;

namespace GroundZero.Application.Features.Orders.DTOs;

public static class OrderMappingExtensions
{
    public static OrderResponse ToResponse(this Order order, string? clientSecret = null)
    {
        return new OrderResponse
        {
            Id = order.Id,
            UserId = order.UserId,
            UserFullName = order.User != null
                ? $"{order.User.FirstName} {order.User.LastName}"
                : string.Empty,
            TotalAmount = order.TotalAmount,
            Status = order.Status,
            StripePaymentIntentId = order.StripePaymentIntentId,
            StripeClientSecret = clientSecret,
            Items = order.Items.Select(i => i.ToResponse()).ToList(),
            CreatedAt = order.CreatedAt
        };
    }

    public static OrderItemResponse ToResponse(this OrderItem item)
    {
        return new OrderItemResponse
        {
            Id = item.Id,
            ProductId = item.ProductId,
            ProductName = item.Product?.Name ?? string.Empty,
            ProductImageUrl = item.Product?.ImageUrl,
            Quantity = item.Quantity,
            UnitPrice = item.UnitPrice
        };
    }
}
