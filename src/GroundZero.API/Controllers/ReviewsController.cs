using GroundZero.Application.Features.Reviews.Commands;
using GroundZero.Application.Features.Reviews.DTOs;
using GroundZero.Application.Features.Reviews.Queries;
using MediatR;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace GroundZero.API.Controllers;

[ApiController]
[Route("api/[controller]")]
[Authorize]
public class ReviewsController : ControllerBase
{
    private readonly IMediator _mediator;

    public ReviewsController(IMediator mediator)
    {
        _mediator = mediator;
    }

    [HttpPost]
    public async Task<IActionResult> Create([FromBody] CreateReviewRequest request)
    {
        var result = await _mediator.Send(new CreateReviewCommand { Request = request });
        return StatusCode(201, result);
    }

    [HttpPut("{id}")]
    public async Task<IActionResult> Update(int id, [FromBody] UpdateReviewRequest request)
    {
        var result = await _mediator.Send(new UpdateReviewCommand { Id = id, Request = request });
        return Ok(result);
    }

    [HttpDelete("{id}")]
    public async Task<IActionResult> Delete(int id)
    {
        await _mediator.Send(new DeleteReviewCommand { Id = id });
        return NoContent();
    }

    [HttpGet("product/{productId}")]
    public async Task<IActionResult> GetProductReviews(
        int productId,
        [FromQuery] int pageNumber = 1,
        [FromQuery] int pageSize = 10)
    {
        var result = await _mediator.Send(new GetProductReviewsQuery
        {
            ProductId = productId,
            PageNumber = pageNumber,
            PageSize = pageSize
        });
        return Ok(result);
    }

    [HttpGet("staff/{staffId}")]
    public async Task<IActionResult> GetStaffReviews(
        int staffId,
        [FromQuery] int pageNumber = 1,
        [FromQuery] int pageSize = 10)
    {
        var result = await _mediator.Send(new GetStaffReviewsQuery
        {
            StaffId = staffId,
            PageNumber = pageNumber,
            PageSize = pageSize
        });
        return Ok(result);
    }

    [HttpGet("{id}")]
    public async Task<IActionResult> GetById(int id)
    {
        var result = await _mediator.Send(new GetReviewByIdQuery { Id = id });
        return Ok(result);
    }
}
