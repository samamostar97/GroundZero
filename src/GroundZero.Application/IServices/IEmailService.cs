namespace GroundZero.Application.IServices;

public interface IEmailService
{
    Task SendPasswordResetCodeAsync(string toEmail, string code, CancellationToken ct = default);
}
