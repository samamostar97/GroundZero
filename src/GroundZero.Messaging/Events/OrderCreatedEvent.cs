namespace GroundZero.Messaging.Events;

public class OrderCreatedEvent
{
    public string Email { get; set; } = string.Empty;
    public int OrderId { get; set; }
    public decimal TotalAmount { get; set; }
    public List<OrderItemInfo> Items { get; set; } = new();
}

public class OrderItemInfo
{
    public string ProductName { get; set; } = string.Empty;
    public int Quantity { get; set; }
    public decimal UnitPrice { get; set; }
}
