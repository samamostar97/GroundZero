using GroundZero.Application.Features.Exercises.Queries;
using GroundZero.Domain.Enums;
using MediatR;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace GroundZero.API.Controllers;

[ApiController]
[Route("api/[controller]")]
[Authorize]
public class ExercisesController : ControllerBase
{
    private readonly IMediator _mediator;

    public ExercisesController(IMediator mediator)
    {
        _mediator = mediator;
    }

    [HttpGet]
    public async Task<IActionResult> GetAll([FromQuery] MuscleGroup? muscleGroup = null)
    {
        var result = await _mediator.Send(new GetExercisesQuery { MuscleGroup = muscleGroup });
        return Ok(result);
    }
}
