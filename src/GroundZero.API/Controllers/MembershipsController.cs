using GroundZero.Application.Features.Memberships.Commands;
using GroundZero.Application.Features.Memberships.DTOs;
using GroundZero.Application.Features.Memberships.Queries;
using GroundZero.Domain.Enums;
using MediatR;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace GroundZero.API.Controllers;

[ApiController]
[Route("api/memberships")]
[Authorize]
public class MembershipsController : ControllerBase
{
    private readonly IMediator _mediator;

    public MembershipsController(IMediator mediator)
    {
        _mediator = mediator;
    }

    [HttpGet("my")]
    public async Task<IActionResult> GetMyMembership()
    {
        var result = await _mediator.Send(new GetMyMembershipQuery());
        return Ok(result);
    }

    [HttpGet("my/history")]
    public async Task<IActionResult> GetMyHistory([FromQuery] int pageNumber = 1, [FromQuery] int pageSize = 10)
    {
        var result = await _mediator.Send(new GetMyMembershipHistoryQuery
        {
            PageNumber = pageNumber,
            PageSize = pageSize
        });
        return Ok(result);
    }

    [HttpGet]
    public async Task<IActionResult> GetAll(
        [FromQuery] int pageNumber = 1,
        [FromQuery] int pageSize = 10,
        [FromQuery] string? search = null,
        [FromQuery] MembershipStatus? status = null,
        [FromQuery] MembershipStatus? excludeStatus = null,
        [FromQuery] int? userId = null,
        [FromQuery] string? sortBy = null,
        [FromQuery] bool sortDescending = true)
    {
        var result = await _mediator.Send(new GetAllMembershipsQuery
        {
            PageNumber = pageNumber,
            PageSize = pageSize,
            Search = search,
            Status = status,
            ExcludeStatus = excludeStatus,
            UserId = userId,
            SortBy = sortBy,
            SortDescending = sortDescending
        });
        return Ok(result);
    }

    [HttpPost]
    public async Task<IActionResult> Assign([FromBody] AssignMembershipRequest request)
    {
        var result = await _mediator.Send(new AssignMembershipCommand { Request = request });
        return StatusCode(201, result);
    }

    [HttpPut("{id}/cancel")]
    public async Task<IActionResult> Cancel(int id)
    {
        var result = await _mediator.Send(new CancelMembershipCommand { Id = id });
        return Ok(result);
    }
}
