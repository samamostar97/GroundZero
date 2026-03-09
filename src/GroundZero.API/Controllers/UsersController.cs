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
        return Ok(result);
    }

    [HttpPut("me")]
    public async Task<IActionResult> UpdateProfile([FromBody] UpdateProfileRequest request)
    {
        var userId = int.Parse(User.FindFirstValue(ClaimTypes.NameIdentifier)!);
        var result = await _mediator.Send(new UpdateProfileCommand { UserId = userId, Request = request });
        return Ok(result);
    }

    [HttpPatch("me/password")]
    public async Task<IActionResult> ChangePassword([FromBody] ChangePasswordRequest request)
    {
        var userId = int.Parse(User.FindFirstValue(ClaimTypes.NameIdentifier)!);
        await _mediator.Send(new ChangePasswordCommand { UserId = userId, Request = request });
        return NoContent();
    }

    [HttpGet("me/gamification")]
    public async Task<IActionResult> GetMyGamification()
    {
        var result = await _mediator.Send(new GetMyGamificationQuery());
        return Ok(result);
    }

    [HttpPost("me/picture")]
    public async Task<IActionResult> UploadProfilePicture(IFormFile file)
    {
        var userId = int.Parse(User.FindFirstValue(ClaimTypes.NameIdentifier)!);
        var result = await _mediator.Send(new UploadProfilePictureCommand
        {
            UserId = userId,
            FileStream = file?.OpenReadStream(),
            FileName = file?.FileName ?? string.Empty,
            FileSize = file?.Length ?? 0
        });
        return Ok(result);
    }

    [HttpGet]
    public async Task<IActionResult> GetAllUsers(
        [FromQuery] int pageNumber = 1,
        [FromQuery] int pageSize = 10,
        [FromQuery] string? search = null,
        [FromQuery] string? sortBy = null,
        [FromQuery] bool sortDescending = true,
        [FromQuery] bool? hasActiveMembership = null)
    {
        var result = await _mediator.Send(new GetAllUsersQuery
        {
            PageNumber = pageNumber,
            PageSize = pageSize,
            Search = search,
            SortBy = sortBy,
            SortDescending = sortDescending,
            HasActiveMembership = hasActiveMembership
        });
        return Ok(result);
    }

    [HttpGet("{id}")]
    public async Task<IActionResult> GetUserById(int id)
    {
        var result = await _mediator.Send(new GetUserByIdQuery { Id = id });
        return Ok(result);
    }

    [HttpDelete("{id}")]
    public async Task<IActionResult> DeleteUser(int id)
    {
        await _mediator.Send(new DeleteUserCommand { Id = id });
        return NoContent();
    }
}
