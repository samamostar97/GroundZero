using GroundZero.Domain.Enums;

namespace GroundZero.Domain.Entities;

public class Order : BaseEntity
{
    public int UserId { get; set; }
    public User User { get; set; } = null!;
    public decimal TotalAmount { get; set; }
    public OrderStatus Status { get; set; } = OrderStatus.Pending;
    public string? StripePaymentIntentId { get; set; }
    public ICollection<OrderItem> Items { get; set; } = new List<OrderItem>();
}
