using GroundZero.Application.Common;
using GroundZero.Application.IRepositories;
using GroundZero.Application.IServices;
using GroundZero.Domain.Enums;
using MediatR;

namespace GroundZero.Application.Features.Reports.Queries;

public class GetRevenueReportQueryHandler : IRequestHandler<GetRevenueReportQuery, ReportFileResult>
{
    private readonly IReportRepository _reportRepository;
    private readonly IPdfReportService _pdfService;
    private readonly IExcelReportService _excelService;

    public GetRevenueReportQueryHandler(
        IReportRepository reportRepository,
        IPdfReportService pdfService,
        IExcelReportService excelService)
    {
        _reportRepository = reportRepository;
        _pdfService = pdfService;
        _excelService = excelService;
    }

    public async Task<ReportFileResult> Handle(GetRevenueReportQuery request, CancellationToken cancellationToken)
    {
        var from = request.From ?? DateTime.UtcNow.AddYears(-1);
        var to = request.To ?? DateTime.UtcNow;

        var data = await _reportRepository.GetRevenueReportAsync(from, to);

        var dateStr = DateTime.UtcNow.ToString("yyyy-MM-dd");

        return request.Format switch
        {
            ReportFormat.Excel => new ReportFileResult
            {
                FileBytes = _excelService.GenerateRevenueReport(data),
                ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
                FileName = $"izvjestaj-prihodi-{dateStr}.xlsx"
            },
            _ => new ReportFileResult
            {
                FileBytes = _pdfService.GenerateRevenueReport(data),
                ContentType = "application/pdf",
                FileName = $"izvjestaj-prihodi-{dateStr}.pdf"
            }
        };
    }
}
