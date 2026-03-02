using GroundZero.Application.Features.GymVisits.Commands;
using GroundZero.Application.Features.GymVisits.DTOs;
using GroundZero.Application.Features.GymVisits.Queries;
using MediatR;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace GroundZero.API.Controllers;

[ApiController]
[Route("api/gym-visits")]
[Authorize]
public class GymVisitsController : ControllerBase
{
    private readonly IMediator _mediator;

    public GymVisitsController(IMediator mediator)
    {
        _mediator = mediator;
    }

    [HttpPost("check-in")]
    public async Task<IActionResult> CheckIn([FromBody] CheckInRequest request)
    {
        var result = await _mediator.Send(new CheckInCommand { Request = request });
        return StatusCode(201, result);
    }

    [HttpPost("check-out")]
    public async Task<IActionResult> CheckOut([FromBody] CheckOutRequest request)
    {
        var result = await _mediator.Send(new CheckOutCommand { Request = request });
        return Ok(result);
    }

    [HttpGet]
    public async Task<IActionResult> GetAll(
        [FromQuery] int pageNumber = 1,
        [FromQuery] int pageSize = 10,
        [FromQuery] string? search = null)
    {
        var result = await _mediator.Send(new GetAllGymVisitsQuery
        {
            PageNumber = pageNumber,
            PageSize = pageSize,
            Search = search
        });
        return Ok(result);
    }

    [HttpGet("my")]
    public async Task<IActionResult> GetMyVisits(
        [FromQuery] int pageNumber = 1,
        [FromQuery] int pageSize = 10)
    {
        var result = await _mediator.Send(new GetUserGymVisitsQuery
        {
            PageNumber = pageNumber,
            PageSize = pageSize
        });
        return Ok(result);
    }
}
