namespace GroundZero.Application.IServices;

public interface ICurrentUserService
{
    int? UserId { get; }
    string? Role { get; }
    bool IsAuthenticated { get; }
}
