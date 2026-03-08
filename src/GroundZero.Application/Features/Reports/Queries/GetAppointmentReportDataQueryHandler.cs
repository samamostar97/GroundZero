using GroundZero.Application.Features.Reports.DTOs;
using GroundZero.Application.IRepositories;
using MediatR;

namespace GroundZero.Application.Features.Reports.Queries;

public class GetAppointmentReportDataQueryHandler : IRequestHandler<GetAppointmentReportDataQuery, AppointmentReportData>
{
    private readonly IReportRepository _reportRepository;

    public GetAppointmentReportDataQueryHandler(IReportRepository reportRepository)
    {
        _reportRepository = reportRepository;
    }

    public async Task<AppointmentReportData> Handle(GetAppointmentReportDataQuery request, CancellationToken cancellationToken)
    {
        var from = request.From ?? DateTime.UtcNow.AddYears(-1);
        var to = request.To ?? DateTime.UtcNow;

        return await _reportRepository.GetAppointmentReportAsync(from, to);
    }
}
