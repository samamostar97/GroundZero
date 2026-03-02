using GroundZero.Application.Features.Reports.DTOs;

namespace GroundZero.Application.IServices;

public interface IPdfReportService
{
    byte[] GenerateRevenueReport(RevenueReportData data);
    byte[] GenerateProductReport(ProductReportData data);
    byte[] GenerateUserReport(UserReportData data);
    byte[] GenerateAppointmentReport(AppointmentReportData data);
    byte[] GenerateGamificationReport(GamificationReportData data);
}
