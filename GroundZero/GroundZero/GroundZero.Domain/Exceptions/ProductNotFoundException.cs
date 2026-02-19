namespace GroundZero.Domain.Exceptions;
public class ProductNotFoundException : Exception
{
    public ProductNotFoundException(Guid id) : base($"Product with Id '{id}' was not found.") { }
}