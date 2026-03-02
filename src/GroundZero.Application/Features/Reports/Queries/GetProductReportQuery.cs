using GroundZero.Application.Common;
using GroundZero.Domain.Enums;
using MediatR;

namespace GroundZero.Application.Features.Reports.Queries;

[AuthorizeRole("Admin")]
public class GetProductReportQuery : IRequest<ReportFileResult>
{
    public DateTime? From { get; set; }
    public DateTime? To { get; set; }
    public int LowStockThreshold { get; set; } = 10;
    public ReportFormat Format { get; set; }
}
