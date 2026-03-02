using GroundZero.Application.Common;
using GroundZero.Domain.Enums;
using MediatR;

namespace GroundZero.Application.Features.Reports.Queries;

[AuthorizeRole("Admin")]
public class GetGamificationReportQuery : IRequest<ReportFileResult>
{
    public DateTime? From { get; set; }
    public DateTime? To { get; set; }
    public ReportFormat Format { get; set; }
}
