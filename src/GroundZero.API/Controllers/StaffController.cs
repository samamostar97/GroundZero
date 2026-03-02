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
        [FromQuery] StaffType? staffType = null)
    {
        var result = await _mediator.Send(new GetAllStaffQuery
        {
            PageNumber = pageNumber,
            PageSize = pageSize,
            Search = search,
            StaffType = staffType
        });
        return StatusCode(result.StatusCode, result);
    }

    [HttpGet("{id}")]
    public async Task<IActionResult> GetById(int id)
    {
        var result = await _mediator.Send(new GetStaffByIdQuery { Id = id });
        return StatusCode(result.StatusCode, result);
    }

    [Authorize(Roles = "Admin")]
    [HttpPost]
    public async Task<IActionResult> Create([FromBody] CreateStaffRequest request)
    {
        var result = await _mediator.Send(new CreateStaffCommand { Request = request });
        return StatusCode(result.StatusCode, result);
    }

    [Authorize(Roles = "Admin")]
    [HttpPut("{id}")]
    public async Task<IActionResult> Update(int id, [FromBody] UpdateStaffRequest request)
    {
        var result = await _mediator.Send(new UpdateStaffCommand { Id = id, Request = request });
        return StatusCode(result.StatusCode, result);
    }

    [Authorize(Roles = "Admin")]
    [HttpPost("{id}/picture")]
    public async Task<IActionResult> UploadPicture(int id, IFormFile file)
    {
        if (file == null || file.Length == 0)
            return BadRequest(new { errors = new[] { "Fajl je obavezan." }, statusCode = 400, isSuccess = false });

        var result = await _mediator.Send(new UploadStaffPictureCommand
        {
            Id = id,
            FileStream = file.OpenReadStream(),
            FileName = file.FileName
        });
        return StatusCode(result.StatusCode, result);
    }

    [Authorize(Roles = "Admin")]
    [HttpDelete("{id}")]
    public async Task<IActionResult> Delete(int id)
    {
        var result = await _mediator.Send(new DeleteStaffCommand { Id = id });
        return StatusCode(result.StatusCode, result);
    }
}
