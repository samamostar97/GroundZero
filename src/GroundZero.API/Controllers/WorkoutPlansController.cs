using GroundZero.Application.Features.WorkoutPlans.Commands;
using GroundZero.Application.Features.WorkoutPlans.DTOs;
using GroundZero.Application.Features.WorkoutPlans.Queries;
using MediatR;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace GroundZero.API.Controllers;

[ApiController]
[Route("api/workout-plans")]
[Authorize]
public class WorkoutPlansController : ControllerBase
{
    private readonly IMediator _mediator;

    public WorkoutPlansController(IMediator mediator)
    {
        _mediator = mediator;
    }

    [HttpPost]
    public async Task<IActionResult> Create([FromBody] CreateWorkoutPlanRequest request)
    {
        var result = await _mediator.Send(new CreateWorkoutPlanCommand { Request = request });
        return StatusCode(201, result);
    }

    [HttpGet]
    public async Task<IActionResult> GetMyPlans(
        [FromQuery] int pageNumber = 1,
        [FromQuery] int pageSize = 10,
        [FromQuery] string? search = null)
    {
        var result = await _mediator.Send(new GetUserWorkoutPlansQuery
        {
            PageNumber = pageNumber,
            PageSize = pageSize,
            Search = search
        });
        return Ok(result);
    }

    [HttpGet("{id}")]
    public async Task<IActionResult> GetById(int id)
    {
        var result = await _mediator.Send(new GetWorkoutPlanByIdQuery { Id = id });
        return Ok(result);
    }

    [HttpPut("{id}")]
    public async Task<IActionResult> Update(int id, [FromBody] UpdateWorkoutPlanRequest request)
    {
        var result = await _mediator.Send(new UpdateWorkoutPlanCommand { Id = id, Request = request });
        return Ok(result);
    }

    [HttpDelete("{id}")]
    public async Task<IActionResult> Delete(int id)
    {
        await _mediator.Send(new DeleteWorkoutPlanCommand { Id = id });
        return NoContent();
    }

    [HttpPost("{id}/days")]
    public async Task<IActionResult> AddDay(int id, [FromBody] AddWorkoutDayRequest request)
    {
        var result = await _mediator.Send(new AddWorkoutDayCommand { WorkoutPlanId = id, Request = request });
        return StatusCode(201, result);
    }

    [HttpPut("{id}/days/{dayId}")]
    public async Task<IActionResult> UpdateDay(int id, int dayId, [FromBody] UpdateWorkoutDayRequest request)
    {
        var result = await _mediator.Send(new UpdateWorkoutDayCommand
        {
            WorkoutPlanId = id,
            DayId = dayId,
            Request = request
        });
        return Ok(result);
    }

    [HttpDelete("{id}/days/{dayId}")]
    public async Task<IActionResult> RemoveDay(int id, int dayId)
    {
        await _mediator.Send(new RemoveWorkoutDayCommand { WorkoutPlanId = id, DayId = dayId });
        return NoContent();
    }

    [HttpPost("{id}/days/{dayId}/exercises")]
    public async Task<IActionResult> AddExercise(int id, int dayId, [FromBody] AddWorkoutExerciseRequest request)
    {
        var result = await _mediator.Send(new AddWorkoutExerciseCommand
        {
            WorkoutPlanId = id,
            DayId = dayId,
            Request = request
        });
        return StatusCode(201, result);
    }

    [HttpPut("{id}/days/{dayId}/exercises/{exerciseId}")]
    public async Task<IActionResult> UpdateExercise(int id, int dayId, int exerciseId, [FromBody] UpdateWorkoutExerciseRequest request)
    {
        var result = await _mediator.Send(new UpdateWorkoutExerciseCommand
        {
            WorkoutPlanId = id,
            DayId = dayId,
            ExerciseId = exerciseId,
            Request = request
        });
        return Ok(result);
    }

    [HttpDelete("{id}/days/{dayId}/exercises/{exerciseId}")]
    public async Task<IActionResult> RemoveExercise(int id, int dayId, int exerciseId)
    {
        await _mediator.Send(new RemoveWorkoutExerciseCommand
        {
            WorkoutPlanId = id,
            DayId = dayId,
            ExerciseId = exerciseId
        });
        return NoContent();
    }
}
