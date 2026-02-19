namespace GroundZero.Domain.Events;
public record ProductCreatedEvent(Guid ProductId, string ProductName, DateTime OccurredAt)
{
    public static ProductCreatedEvent Create(Guid id, string name) => new(id, name, DateTime.UtcNow);
}