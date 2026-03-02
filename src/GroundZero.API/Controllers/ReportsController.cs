using GroundZero.Application.Features.Reports.Queries;
using GroundZero.Domain.Enums;
using MediatR;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace GroundZero.API.Controllers;

[ApiController]
[Route("api/[controller]")]
[Authorize]
public class ReportsController : ControllerBase
{
    private readonly IMediator _mediator;

    public ReportsController(IMediator mediator)
    {
        _mediator = mediator;
    }

    [HttpGet("revenue")]
    public async Task<IActionResult> GetRevenueReport(
        [FromQuery] DateTime? from = null,
        [FromQuery] DateTime? to = null,
        [FromQuery] ReportFormat format = ReportFormat.Pdf)
    {
        var result = await _mediator.Send(new GetRevenueReportQuery { From = from, To = to, Format = format });
        return File(result.FileBytes, result.ContentType, result.FileName);
    }

    [HttpGet("products")]
    public async Task<IActionResult> GetProductReport(
        [FromQuery] DateTime? from = null,
        [FromQuery] DateTime? to = null,
        [FromQuery] int lowStockThreshold = 10,
        [FromQuery] ReportFormat format = ReportFormat.Pdf)
    {
        var result = await _mediator.Send(new GetProductReportQuery
        {
            From = from,
            To = to,
            LowStockThreshold = lowStockThreshold,
            Format = format
        });
        return File(result.FileBytes, result.ContentType, result.FileName);
    }

    [HttpGet("users")]
    public async Task<IActionResult> GetUserReport(
        [FromQuery] DateTime? from = null,
        [FromQuery] DateTime? to = null,
        [FromQuery] ReportFormat format = ReportFormat.Pdf)
    {
        var result = await _mediator.Send(new GetUserReportQuery { From = from, To = to, Format = format });
        return File(result.FileBytes, result.ContentType, result.FileName);
    }

    [HttpGet("appointments")]
    public async Task<IActionResult> GetAppointmentReport(
        [FromQuery] DateTime? from = null,
        [FromQuery] DateTime? to = null,
        [FromQuery] ReportFormat format = ReportFormat.Pdf)
    {
        var result = await _mediator.Send(new GetAppointmentReportQuery { From = from, To = to, Format = format });
        return File(result.FileBytes, result.ContentType, result.FileName);
    }

    [HttpGet("gamification")]
    public async Task<IActionResult> GetGamificationReport(
        [FromQuery] DateTime? from = null,
        [FromQuery] DateTime? to = null,
        [FromQuery] ReportFormat format = ReportFormat.Pdf)
    {
        var result = await _mediator.Send(new GetGamificationReportQuery { From = from, To = to, Format = format });
        return File(result.FileBytes, result.ContentType, result.FileName);
    }
}
