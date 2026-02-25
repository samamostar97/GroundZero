namespace GroundZero.Application.Exceptions;

public class EntityHasDependentsException : Exception
{
    public EntityHasDependentsException() : base() { }

    public EntityHasDependentsException(string message) : base(message) { }

    public EntityHasDependentsException(string message, Exception innerException)
        : base(message, innerException) { }

    public EntityHasDependentsException(string name, object key)
        : base($"Entity \"{name}\" ({key}) cannot be deleted because it has dependent records.") { }
}
