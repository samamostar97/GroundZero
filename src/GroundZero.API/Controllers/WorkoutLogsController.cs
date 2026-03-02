using GroundZero.Application.Features.WorkoutLogs.Commands;
using GroundZero.Application.Features.WorkoutLogs.DTOs;
using GroundZero.Application.Features.WorkoutLogs.Queries;
using MediatR;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace GroundZero.API.Controllers;

[ApiController]
[Route("api/workout-logs")]
[Authorize]
public class WorkoutLogsController : ControllerBase
{
    private readonly IMediator _mediator;

    public WorkoutLogsController(IMediator mediator)
    {
        _mediator = mediator;
    }

    [HttpPost]
    public async Task<IActionResult> Create([FromBody] CreateWorkoutLogRequest request)
    {
        var result = await _mediator.Send(new CreateWorkoutLogCommand { Request = request });
        return StatusCode(201, result);
    }

    [HttpGet]
    public async Task<IActionResult> GetMyLogs(
        [FromQuery] int pageNumber = 1,
        [FromQuery] int pageSize = 10)
    {
        var result = await _mediator.Send(new GetUserWorkoutLogsQuery
        {
            PageNumber = pageNumber,
            PageSize = pageSize
        });
        return Ok(result);
    }

    [HttpGet("{id}")]
    public async Task<IActionResult> GetById(int id)
    {
        var result = await _mediator.Send(new GetWorkoutLogByIdQuery { Id = id });
        return Ok(result);
    }
}
