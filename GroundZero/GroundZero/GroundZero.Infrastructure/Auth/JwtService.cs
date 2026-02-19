using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;
using Microsoft.AspNetCore.Identity;
using Microsoft.Extensions.Configuration;
using Microsoft.IdentityModel.Tokens;

namespace GroundZero.Infrastructure.Auth;

public class JwtService
{
    private readonly IConfiguration _cfg;
    private readonly UserManager<IdentityUser> _um;
    public JwtService(IConfiguration cfg, UserManager<IdentityUser> um) { _cfg = cfg; _um = um; }

    public async Task<string> GenerateTokenAsync(IdentityUser user)
    {
        var roles = await _um.GetRolesAsync(user);
        var claims = new List<Claim>
        { new(ClaimTypes.NameIdentifier, user.Id), new(ClaimTypes.Email, user.Email ?? ""),
          new(JwtRegisteredClaimNames.Jti, Guid.NewGuid().ToString()) };
        claims.AddRange(roles.Select(r => new Claim(ClaimTypes.Role, r)));
        var key = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(_cfg["Jwt:Key"] ?? throw new InvalidOperationException("JWT Key missing")));
        var token = new JwtSecurityToken(issuer: _cfg["Jwt:Issuer"], audience: _cfg["Jwt:Audience"], claims: claims,
            expires: DateTime.UtcNow.AddHours(double.Parse(_cfg["Jwt:ExpiresInHours"] ?? "24")),
            signingCredentials: new SigningCredentials(key, SecurityAlgorithms.HmacSha256));
        return new JwtSecurityTokenHandler().WriteToken(token);
    }
}