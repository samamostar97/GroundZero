using GroundZero.Application.Features.Memberships.Commands;
using GroundZero.Application.Features.Memberships.DTOs;
using GroundZero.Application.Features.Memberships.Queries;
using MediatR;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace GroundZero.API.Controllers;

[ApiController]
[Route("api/membership-plans")]
[Authorize]
public class MembershipPlansController : ControllerBase
{
    private readonly IMediator _mediator;

    public MembershipPlansController(IMediator mediator)
    {
        _mediator = mediator;
    }

    [HttpGet]
    public async Task<IActionResult> GetAll([FromQuery] bool? isActive = null)
    {
        var result = await _mediator.Send(new GetAllMembershipPlansQuery { IsActive = isActive });
        return Ok(result);
    }

    [HttpGet("{id}")]
    public async Task<IActionResult> GetById(int id)
    {
        var result = await _mediator.Send(new GetMembershipPlanByIdQuery { Id = id });
        return Ok(result);
    }

    [HttpPost]
    public async Task<IActionResult> Create([FromBody] CreateMembershipPlanRequest request)
    {
        var result = await _mediator.Send(new CreateMembershipPlanCommand { Request = request });
        return CreatedAtAction(nameof(GetById), new { id = result.Id }, result);
    }

    [HttpPut("{id}")]
    public async Task<IActionResult> Update(int id, [FromBody] UpdateMembershipPlanRequest request)
    {
        var result = await _mediator.Send(new UpdateMembershipPlanCommand { Id = id, Request = request });
        return Ok(result);
    }

    [HttpDelete("{id}")]
    public async Task<IActionResult> Delete(int id)
    {
        await _mediator.Send(new DeleteMembershipPlanCommand { Id = id });
        return NoContent();
    }
}
