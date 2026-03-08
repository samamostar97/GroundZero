using GroundZero.Messaging.Events;

namespace GroundZero.Application.IServices;

public interface IEmailService
{
    Task SendPasswordResetCodeAsync(string toEmail, string code, CancellationToken ct = default);
    Task SendOrderConfirmationAsync(string toEmail, int orderId, decimal totalAmount, List<OrderItemInfo> items, CancellationToken ct = default);
    Task SendOrderStatusChangedAsync(string toEmail, int orderId, string newStatus, CancellationToken ct = default);
    Task SendAppointmentStatusAsync(string toEmail, string staffName, DateTime scheduledAt, string newStatus, CancellationToken ct = default);
    Task SendLevelUpAsync(string toEmail, string userName, int newLevel, CancellationToken ct = default);
}
