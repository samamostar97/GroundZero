using GroundZero.Application.Features.Recommendations.Queries;
using MediatR;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace GroundZero.API.Controllers;

[ApiController]
[Route("api/[controller]")]
[Authorize]
public class RecommendationsController : ControllerBase
{
    private readonly IMediator _mediator;

    public RecommendationsController(IMediator mediator)
    {
        _mediator = mediator;
    }

    [HttpGet("product/{productId}")]
    public async Task<IActionResult> GetProductRecommendations(int productId, [FromQuery] int limit = 10)
    {
        var result = await _mediator.Send(new GetProductRecommendationsQuery
        {
            ProductId = productId,
            Limit = limit
        });

        return Ok(result);
    }

    [HttpGet("user")]
    public async Task<IActionResult> GetUserRecommendations([FromQuery] int limit = 10)
    {
        var result = await _mediator.Send(new GetUserRecommendationsQuery
        {
            Limit = limit
        });

        return Ok(result);
    }
}
