using Microsoft.AspNetCore.Identity; using Microsoft.AspNetCore.Mvc;
using GroundZero.Infrastructure.Auth;
namespace GroundZero.API.Controllers;

[ApiController, Route("api/[controller]")]
public class AuthController : ControllerBase
{
    private readonly UserManager<IdentityUser> _um; private readonly JwtService _jwt;
    public AuthController(UserManager<IdentityUser> um, JwtService jwt) { _um = um; _jwt = jwt; }

    [HttpPost("register")]
    public async Task<IActionResult> Register([FromBody] RegisterReq req)
    { var u = new IdentityUser { UserName = req.Email, Email = req.Email };
      var r = await _um.CreateAsync(u, req.Password); if (!r.Succeeded) return BadRequest(r.Errors);
      await _um.AddToRoleAsync(u, "User"); return Ok(new { message = "Registration successful." }); }

    [HttpPost("login")]
    public async Task<IActionResult> Login([FromBody] LoginReq req)
    { var u = await _um.FindByEmailAsync(req.Email);
      if (u is null || !await _um.CheckPasswordAsync(u, req.Password)) return Unauthorized(new { message = "Invalid credentials." });
      return Ok(new LoginResp(await _jwt.GenerateTokenAsync(u), u.Email!, u.Id)); }
}
public record RegisterReq(string Email, string Password);
public record LoginReq(string Email, string Password);
public record LoginResp(string Token, string Email, string UserId);