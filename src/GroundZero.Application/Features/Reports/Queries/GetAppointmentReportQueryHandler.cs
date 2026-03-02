using GroundZero.Application.Common;
using GroundZero.Application.IRepositories;
using GroundZero.Application.IServices;
using GroundZero.Domain.Enums;
using MediatR;

namespace GroundZero.Application.Features.Reports.Queries;

public class GetAppointmentReportQueryHandler : IRequestHandler<GetAppointmentReportQuery, ReportFileResult>
{
    private readonly IReportRepository _reportRepository;
    private readonly IPdfReportService _pdfService;
    private readonly IExcelReportService _excelService;

    public GetAppointmentReportQueryHandler(
        IReportRepository reportRepository,
        IPdfReportService pdfService,
        IExcelReportService excelService)
    {
        _reportRepository = reportRepository;
        _pdfService = pdfService;
        _excelService = excelService;
    }

    public async Task<ReportFileResult> Handle(GetAppointmentReportQuery request, CancellationToken cancellationToken)
    {
        var from = request.From ?? DateTime.UtcNow.AddYears(-1);
        var to = request.To ?? DateTime.UtcNow;

        var data = await _reportRepository.GetAppointmentReportAsync(from, to);

        var dateStr = DateTime.UtcNow.ToString("yyyy-MM-dd");

        return request.Format switch
        {
            ReportFormat.Excel => new ReportFileResult
            {
                FileBytes = _excelService.GenerateAppointmentReport(data),
                ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
                FileName = $"izvjestaj-termini-{dateStr}.xlsx"
            },
            _ => new ReportFileResult
            {
                FileBytes = _pdfService.GenerateAppointmentReport(data),
                ContentType = "application/pdf",
                FileName = $"izvjestaj-termini-{dateStr}.pdf"
            }
        };
    }
}
