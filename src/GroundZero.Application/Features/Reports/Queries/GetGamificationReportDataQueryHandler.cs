using GroundZero.Application.Features.Reports.DTOs;
using GroundZero.Application.IRepositories;
using MediatR;

namespace GroundZero.Application.Features.Reports.Queries;

public class GetGamificationReportDataQueryHandler : IRequestHandler<GetGamificationReportDataQuery, GamificationReportData>
{
    private readonly IReportRepository _reportRepository;

    public GetGamificationReportDataQueryHandler(IReportRepository reportRepository)
    {
        _reportRepository = reportRepository;
    }

    public async Task<GamificationReportData> Handle(GetGamificationReportDataQuery request, CancellationToken cancellationToken)
    {
        var from = request.From ?? DateTime.UtcNow.AddYears(-1);
        var to = request.To ?? DateTime.UtcNow;

        return await _reportRepository.GetGamificationReportAsync(from, to);
    }
}
