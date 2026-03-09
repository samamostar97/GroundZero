using GroundZero.Application.Features.Dashboard.Queries;
using GroundZero.Application.Features.Dashboard.DTOs;
using MediatR;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace GroundZero.API.Controllers;

[ApiController]
[Route("api/[controller]")]
[Authorize]
public class DashboardController : ControllerBase
{
    private readonly IMediator _mediator;

    public DashboardController(IMediator mediator)
    {
        _mediator = mediator;
    }

    [HttpGet]
    public async Task<IActionResult> Get()
    {
        var result = await _mediator.Send(new GetDashboardQuery());
        return Ok(result);
    }

    [HttpGet("activity-feed")]
    public async Task<IActionResult> GetActivityFeed([FromQuery] int count = 20)
    {
        var result = await _mediator.Send(new GetActivityFeedQuery { Count = count });
        return Ok(result);
    }
}
