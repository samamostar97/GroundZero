using GroundZero.Application.IServices;
using MailKit.Net.Smtp;
using MimeKit;

namespace GroundZero.Infrastructure.Services;

public class EmailService : IEmailService
{
    private readonly string _smtpHost;
    private readonly int _smtpPort;
    private readonly string _smtpEmail;
    private readonly string _smtpPassword;

    public EmailService()
    {
        _smtpHost = Environment.GetEnvironmentVariable("SMTP_HOST") ?? "smtp.gmail.com";
        _smtpPort = int.Parse(Environment.GetEnvironmentVariable("SMTP_PORT") ?? "587");
        _smtpEmail = Environment.GetEnvironmentVariable("SMTP_EMAIL") ?? "";
        _smtpPassword = Environment.GetEnvironmentVariable("SMTP_PASSWORD") ?? "";
    }

    public async Task SendPasswordResetCodeAsync(string toEmail, string code, CancellationToken ct = default)
    {
        var message = new MimeMessage();
        message.From.Add(new MailboxAddress("GroundZero", _smtpEmail));
        message.To.Add(new MailboxAddress("", toEmail));
        message.Subject = "Reset lozinke - GroundZero";

        message.Body = new TextPart("html")
        {
            Text = $@"
                <div style='font-family: Arial, sans-serif; max-width: 500px; margin: 0 auto; padding: 20px;'>
                    <h2 style='color: #333; text-align: center;'>GroundZero</h2>
                    <p>Poštovani,</p>
                    <p>Primili smo zahtjev za reset vaše lozinke. Vaš kod za verifikaciju je:</p>
                    <div style='text-align: center; margin: 30px 0;'>
                        <span style='font-size: 32px; font-weight: bold; letter-spacing: 8px;
                                     background-color: #f4f4f4; padding: 15px 25px; border-radius: 8px;'>
                            {code}
                        </span>
                    </div>
                    <p>Kod je validan <strong>15 minuta</strong>.</p>
                    <p>Ako niste zatražili reset lozinke, ignorirajte ovaj email.</p>
                    <hr style='border: none; border-top: 1px solid #eee; margin: 20px 0;' />
                    <p style='color: #999; font-size: 12px; text-align: center;'>GroundZero Gym Management</p>
                </div>"
        };

        using var client = new SmtpClient();
        await client.ConnectAsync(_smtpHost, _smtpPort, MailKit.Security.SecureSocketOptions.StartTls, ct);
        await client.AuthenticateAsync(_smtpEmail, _smtpPassword, ct);
        await client.SendAsync(message, ct);
        await client.DisconnectAsync(true, ct);
    }
}
