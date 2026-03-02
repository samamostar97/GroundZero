namespace GroundZero.Application.Common;

[AttributeUsage(AttributeTargets.Class, AllowMultiple = false)]
public class AuthorizeRoleAttribute : Attribute
{
    public string Role { get; }

    public AuthorizeRoleAttribute(string role)
    {
        Role = role;
    }
}
