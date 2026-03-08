using GroundZero.Application.Features.Reports.DTOs;
using GroundZero.Application.IRepositories;
using MediatR;

namespace GroundZero.Application.Features.Reports.Queries;

public class GetUserReportDataQueryHandler : IRequestHandler<GetUserReportDataQuery, UserReportData>
{
    private readonly IReportRepository _reportRepository;

    public GetUserReportDataQueryHandler(IReportRepository reportRepository)
    {
        _reportRepository = reportRepository;
    }

    public async Task<UserReportData> Handle(GetUserReportDataQuery request, CancellationToken cancellationToken)
    {
        var from = request.From ?? DateTime.UtcNow.AddYears(-1);
        var to = request.To ?? DateTime.UtcNow;

        return await _reportRepository.GetUserReportAsync(from, to);
    }
}
