using GroundZero.Application.Features.Reports.DTOs;

namespace GroundZero.Application.IRepositories;

public interface IReportRepository
{
    Task<RevenueReportData> GetRevenueReportAsync(DateTime from, DateTime to);
    Task<ProductReportData> GetProductReportAsync(DateTime from, DateTime to, int lowStockThreshold);
    Task<UserReportData> GetUserReportAsync(DateTime from, DateTime to);
    Task<AppointmentReportData> GetAppointmentReportAsync(DateTime from, DateTime to);
    Task<GamificationReportData> GetGamificationReportAsync(DateTime from, DateTime to);
}
