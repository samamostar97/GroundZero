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

    // ── File export endpoints ──────────────────────────────────────

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

    // ── JSON data endpoints ────────────────────────────────────────

    [HttpGet("revenue/data")]
    public async Task<IActionResult> GetRevenueReportData(
        [FromQuery] DateTime? from = null,
        [FromQuery] DateTime? to = null)
    {
        var result = await _mediator.Send(new GetRevenueReportDataQuery { From = from, To = to });
        return Ok(result);
    }

    [HttpGet("products/data")]
    public async Task<IActionResult> GetProductReportData(
        [FromQuery] DateTime? from = null,
        [FromQuery] DateTime? to = null,
        [FromQuery] int lowStockThreshold = 10)
    {
        var result = await _mediator.Send(new GetProductReportDataQuery
        {
            From = from,
            To = to,
            LowStockThreshold = lowStockThreshold
        });
        return Ok(result);
    }

    [HttpGet("users/data")]
    public async Task<IActionResult> GetUserReportData(
        [FromQuery] DateTime? from = null,
        [FromQuery] DateTime? to = null)
    {
        var result = await _mediator.Send(new GetUserReportDataQuery { From = from, To = to });
        return Ok(result);
    }

    [HttpGet("appointments/data")]
    public async Task<IActionResult> GetAppointmentReportData(
        [FromQuery] DateTime? from = null,
        [FromQuery] DateTime? to = null)
    {
        var result = await _mediator.Send(new GetAppointmentReportDataQuery { From = from, To = to });
        return Ok(result);
    }

    [HttpGet("gamification/data")]
    public async Task<IActionResult> GetGamificationReportData(
        [FromQuery] DateTime? from = null,
        [FromQuery] DateTime? to = null)
    {
        var result = await _mediator.Send(new GetGamificationReportDataQuery { From = from, To = to });
        return Ok(result);
    }
}
