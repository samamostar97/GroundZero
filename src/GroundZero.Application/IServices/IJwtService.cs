using GroundZero.Domain.Entities;

namespace GroundZero.Application.IServices;

public interface IJwtService
{
    string GenerateAccessToken(User user);
    string GenerateRefreshToken();
}
