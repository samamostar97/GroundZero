using System.Security.Claims;
using GroundZero.Application.Features.Users.Commands;
using GroundZero.Application.Features.Users.DTOs;
using GroundZero.Application.Features.Users.Queries;
using MediatR;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace GroundZero.API.Controllers;

[ApiController]
[Route("api/[controller]")]
[Authorize]
public class UsersController : ControllerBase
{
    private readonly IMediator _mediator;

    public UsersController(IMediator mediator)
    {
        _mediator = mediator;
    }

    [HttpGet("me")]
    public async Task<IActionResult> GetCurrentUser()
    {
        var userId = int.Parse(User.FindFirstValue(ClaimTypes.NameIdentifier)!);
        var result = await _mediator.Send(new GetCurrentUserQuery { UserId = userId });
        return StatusCode(result.StatusCode, result);
    }

    [HttpPut("me")]
    public async Task<IActionResult> UpdateProfile([FromBody] UpdateProfileRequest request)
    {
        var userId = int.Parse(User.FindFirstValue(ClaimTypes.NameIdentifier)!);
        var result = await _mediator.Send(new UpdateProfileCommand { UserId = userId, Request = request });
        return StatusCode(result.StatusCode, result);
    }

    [HttpPost("me/picture")]
    public async Task<IActionResult> UploadProfilePicture(IFormFile file)
    {
        if (file == null || file.Length == 0)
            return BadRequest(new { errors = new[] { "Fajl je obavezan." }, statusCode = 400, isSuccess = false });

        var userId = int.Parse(User.FindFirstValue(ClaimTypes.NameIdentifier)!);
        var result = await _mediator.Send(new UploadProfilePictureCommand
        {
            UserId = userId,
            FileStream = file.OpenReadStream(),
            FileName = file.FileName
        });
        return StatusCode(result.StatusCode, result);
    }

    [Authorize(Roles = "Admin")]
    [HttpGet]
    public async Task<IActionResult> GetAllUsers([FromQuery] int pageNumber = 1, [FromQuery] int pageSize = 10, [FromQuery] string? search = null)
    {
        var result = await _mediator.Send(new GetAllUsersQuery
        {
            PageNumber = pageNumber,
            PageSize = pageSize,
            Search = search
        });
        return StatusCode(result.StatusCode, result);
    }

    [Authorize(Roles = "Admin")]
    [HttpGet("{id}")]
    public async Task<IActionResult> GetUserById(int id)
    {
        var result = await _mediator.Send(new GetUserByIdQuery { Id = id });
        return StatusCode(result.StatusCode, result);
    }

    [Authorize(Roles = "Admin")]
    [HttpDelete("{id}")]
    public async Task<IActionResult> DeleteUser(int id)
    {
        var result = await _mediator.Send(new DeleteUserCommand { Id = id });
        return StatusCode(result.StatusCode, result);
    }
}
