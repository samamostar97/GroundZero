using GroundZero.Application.Features.Reports.DTOs;
using GroundZero.Application.IRepositories;
using MediatR;

namespace GroundZero.Application.Features.Reports.Queries;

public class GetProductReportDataQueryHandler : IRequestHandler<GetProductReportDataQuery, ProductReportData>
{
    private readonly IReportRepository _reportRepository;

    public GetProductReportDataQueryHandler(IReportRepository reportRepository)
    {
        _reportRepository = reportRepository;
    }

    public async Task<ProductReportData> Handle(GetProductReportDataQuery request, CancellationToken cancellationToken)
    {
        var from = request.From ?? DateTime.UtcNow.AddYears(-1);
        var to = request.To ?? DateTime.UtcNow;

        return await _reportRepository.GetProductReportAsync(from, to, request.LowStockThreshold);
    }
}
