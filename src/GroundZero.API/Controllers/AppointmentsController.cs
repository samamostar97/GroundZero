using GroundZero.Application.Features.Appointments.Commands;
using GroundZero.Application.Features.Appointments.DTOs;
using GroundZero.Application.Features.Appointments.Queries;
using GroundZero.Domain.Enums;
using MediatR;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace GroundZero.API.Controllers;

[ApiController]
[Route("api/[controller]")]
[Authorize]
public class AppointmentsController : ControllerBase
{
    private readonly IMediator _mediator;

    public AppointmentsController(IMediator mediator)
    {
        _mediator = mediator;
    }

    [HttpPost]
    public async Task<IActionResult> Create([FromBody] CreateAppointmentRequest request)
    {
        var result = await _mediator.Send(new CreateAppointmentCommand { Request = request });
        return StatusCode(201, result);
    }

    [HttpGet("my")]
    public async Task<IActionResult> GetMyAppointments(
        [FromQuery] int pageNumber = 1,
        [FromQuery] int pageSize = 10,
        [FromQuery] AppointmentStatus? status = null)
    {
        var result = await _mediator.Send(new GetUserAppointmentsQuery
        {
            PageNumber = pageNumber,
            PageSize = pageSize,
            Status = status
        });
        return Ok(result);
    }

    [HttpGet]
    public async Task<IActionResult> GetAll(
        [FromQuery] int pageNumber = 1,
        [FromQuery] int pageSize = 10,
        [FromQuery] string? search = null,
        [FromQuery] AppointmentStatus? status = null,
        [FromQuery] int? staffId = null,
        [FromQuery] int? userId = null,
        [FromQuery] string? sortBy = null,
        [FromQuery] bool sortDescending = true,
        [FromQuery] string? excludeStatuses = null)
    {
        var result = await _mediator.Send(new GetAllAppointmentsQuery
        {
            PageNumber = pageNumber,
            PageSize = pageSize,
            Search = search,
            Status = status,
            StaffId = staffId,
            UserId = userId,
            SortBy = sortBy,
            SortDescending = sortDescending,
            ExcludeStatuses = excludeStatuses
        });
        return Ok(result);
    }

    [HttpGet("{id}")]
    public async Task<IActionResult> GetById(int id)
    {
        var result = await _mediator.Send(new GetAppointmentByIdQuery { Id = id });
        return Ok(result);
    }

    [HttpPut("{id}/status")]
    public async Task<IActionResult> UpdateStatus(int id, [FromBody] UpdateAppointmentStatusRequest request)
    {
        var result = await _mediator.Send(new UpdateAppointmentStatusCommand { Id = id, Request = request });
        return Ok(result);
    }

    [HttpPut("{id}/cancel")]
    public async Task<IActionResult> Cancel(int id)
    {
        var result = await _mediator.Send(new CancelAppointmentCommand { Id = id });
        return Ok(result);
    }
}
