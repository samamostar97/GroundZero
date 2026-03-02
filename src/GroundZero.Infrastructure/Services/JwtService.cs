using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Security.Cryptography;
using System.Text;
using GroundZero.Application.IServices;
using GroundZero.Domain.Entities;
using Microsoft.IdentityModel.Tokens;

namespace GroundZero.Infrastructure.Services;

public class JwtService : IJwtService
{
    private readonly string _secret;
    private readonly string _issuer;
    private readonly string _audience;
    private readonly int _accessTokenExpiryMinutes;

    public JwtService()
    {
        _secret = Environment.GetEnvironmentVariable("JWT_SECRET")
            ?? throw new InvalidOperationException("JWT_SECRET is not configured.");
        _issuer = Environment.GetEnvironmentVariable("JWT_ISSUER") ?? "GroundZero";
        _audience = Environment.GetEnvironmentVariable("JWT_AUDIENCE") ?? "GroundZeroApp";
        _accessTokenExpiryMinutes = int.Parse(
            Environment.GetEnvironmentVariable("JWT_ACCESS_TOKEN_EXPIRY_MINUTES") ?? "30");
    }

    public string GenerateAccessToken(User user)
    {
        var key = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(_secret));
        var credentials = new SigningCredentials(key, SecurityAlgorithms.HmacSha256);

        var claims = new List<Claim>
        {
            new(ClaimTypes.NameIdentifier, user.Id.ToString()),
            new(ClaimTypes.Email, user.Email),
            new(ClaimTypes.GivenName, user.FirstName),
            new(ClaimTypes.Surname, user.LastName),
            new(ClaimTypes.Role, user.Role.ToString())
        };

        var token = new JwtSecurityToken(
            issuer: _issuer,
            audience: _audience,
            claims: claims,
            expires: DateTime.UtcNow.AddMinutes(_accessTokenExpiryMinutes),
            signingCredentials: credentials);

        return new JwtSecurityTokenHandler().WriteToken(token);
    }

    public string GenerateRefreshToken()
    {
        var randomBytes = new byte[64];
        using var rng = RandomNumberGenerator.Create();
        rng.GetBytes(randomBytes);
        return Convert.ToBase64String(randomBytes);
    }
}
