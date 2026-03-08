using GroundZero.Application.Features.Reports.DTOs;
using GroundZero.Application.IRepositories;
using MediatR;

namespace GroundZero.Application.Features.Reports.Queries;

public class GetRevenueReportDataQueryHandler : IRequestHandler<GetRevenueReportDataQuery, RevenueReportData>
{
    private readonly IReportRepository _reportRepository;

    public GetRevenueReportDataQueryHandler(IReportRepository reportRepository)
    {
        _reportRepository = reportRepository;
    }

    public async Task<RevenueReportData> Handle(GetRevenueReportDataQuery request, CancellationToken cancellationToken)
    {
        var from = request.From ?? DateTime.UtcNow.AddYears(-1);
        var to = request.To ?? DateTime.UtcNow;

        return await _reportRepository.GetRevenueReportAsync(from, to);
    }
}
