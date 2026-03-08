using GroundZero.Application.Features.Staff.Commands;
using GroundZero.Application.Features.Staff.DTOs;
using GroundZero.Application.Features.Staff.Queries;
using GroundZero.Domain.Enums;
using MediatR;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace GroundZero.API.Controllers;

[ApiController]
[Route("api/[controller]")]
[Authorize]
public class StaffController : ControllerBase
{
    private readonly IMediator _mediator;

    public StaffController(IMediator mediator)
    {
        _mediator = mediator;
    }

    [HttpGet]
    public async Task<IActionResult> GetAll(
        [FromQuery] int pageNumber = 1,
        [FromQuery] int pageSize = 10,
        [FromQuery] string? search = null,
        [FromQuery] StaffType? staffType = null,
        [FromQuery] string? sortBy = null,
        [FromQuery] bool sortDescending = true)
    {
        var result = await _mediator.Send(new GetAllStaffQuery
        {
            PageNumber = pageNumber,
            PageSize = pageSize,
            Search = search,
            StaffType = staffType,
            SortBy = sortBy,
            SortDescending = sortDescending
        });
        return Ok(result);
    }

    [HttpGet("{id}")]
    public async Task<IActionResult> GetById(int id)
    {
        var result = await _mediator.Send(new GetStaffByIdQuery { Id = id });
        return Ok(result);
    }

    [HttpGet("{id}/available-slots")]
    public async Task<IActionResult> GetAvailableSlots(int id, [FromQuery] DateTime date)
    {
        var result = await _mediator.Send(new GetStaffAvailableSlotsQuery
        {
            StaffId = id,
            Date = date
        });
        return Ok(result);
    }

    [HttpPost]
    public async Task<IActionResult> Create([FromBody] CreateStaffRequest request)
    {
        var result = await _mediator.Send(new CreateStaffCommand { Request = request });
        return CreatedAtAction(nameof(GetById), new { id = result.Id }, result);
    }

    [HttpPut("{id}")]
    public async Task<IActionResult> Update(int id, [FromBody] UpdateStaffRequest request)
    {
        var result = await _mediator.Send(new UpdateStaffCommand { Id = id, Request = request });
        return Ok(result);
    }

    [HttpPost("{id}/picture")]
    public async Task<IActionResult> UploadPicture(int id, IFormFile file)
    {
        var result = await _mediator.Send(new UploadStaffPictureCommand
        {
            Id = id,
            FileStream = file?.OpenReadStream(),
            FileName = file?.FileName ?? string.Empty,
            FileSize = file?.Length ?? 0
        });
        return Ok(result);
    }

    [HttpDelete("{id}")]
    public async Task<IActionResult> Delete(int id)
    {
        await _mediator.Send(new DeleteStaffCommand { Id = id });
        return NoContent();
    }
}
