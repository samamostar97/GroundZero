using GroundZero.Application.Common;
using GroundZero.Application.Features.Reports.DTOs;
using MediatR;

namespace GroundZero.Application.Features.Reports.Queries;

[AuthorizeRole("Admin")]
public class GetProductReportDataQuery : IRequest<ProductReportData>
{
    public DateTime? From { get; set; }
    public DateTime? To { get; set; }
    public int LowStockThreshold { get; set; } = 10;
}
