using GroundZero.Application.Features.Orders.Commands;
using GroundZero.Application.Features.Orders.DTOs;
using GroundZero.Application.Features.Orders.Queries;
using GroundZero.Domain.Enums;
using MediatR;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace GroundZero.API.Controllers;

[ApiController]
[Route("api/[controller]")]
[Authorize]
public class OrdersController : ControllerBase
{
    private readonly IMediator _mediator;

    public OrdersController(IMediator mediator)
    {
        _mediator = mediator;
    }

    [HttpPost]
    public async Task<IActionResult> Create([FromBody] CreateOrderRequest request)
    {
        var result = await _mediator.Send(new CreateOrderCommand { Request = request });
        return StatusCode(201, result);
    }

    [HttpGet("my")]
    public async Task<IActionResult> GetMyOrders(
        [FromQuery] int pageNumber = 1,
        [FromQuery] int pageSize = 10,
        [FromQuery] OrderStatus? status = null)
    {
        var result = await _mediator.Send(new GetUserOrdersQuery
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
        [FromQuery] OrderStatus? status = null,
        [FromQuery] int? userId = null)
    {
        var result = await _mediator.Send(new GetAllOrdersQuery
        {
            PageNumber = pageNumber,
            PageSize = pageSize,
            Search = search,
            Status = status,
            UserId = userId
        });
        return Ok(result);
    }

    [HttpGet("{id}")]
    public async Task<IActionResult> GetById(int id)
    {
        var result = await _mediator.Send(new GetOrderByIdQuery { Id = id });
        return Ok(result);
    }

    [HttpPut("{id}/status")]
    public async Task<IActionResult> UpdateStatus(int id, [FromBody] UpdateOrderStatusRequest request)
    {
        var result = await _mediator.Send(new UpdateOrderStatusCommand { Id = id, Request = request });
        return Ok(result);
    }
}
