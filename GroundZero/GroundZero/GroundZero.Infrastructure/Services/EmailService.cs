using MailKit.Net.Smtp;
using Microsoft.Extensions.Configuration;
using MimeKit;
using GroundZero.Application.Common.Interfaces;
namespace GroundZero.Infrastructure.Services;
public class EmailService : IEmailService
{
    private readonly IConfiguration _cfg;
    public EmailService(IConfiguration cfg) => _cfg = cfg;
    public async Task SendAsync(string to, string subject, string htmlBody, CancellationToken ct = default)
    {
        var email = new MimeMessage();
        email.From.Add(MailboxAddress.Parse(_cfg["Email:From"]));
        email.To.Add(MailboxAddress.Parse(to));
        email.Subject = subject;
        email.Body = new TextPart(MimeKit.Text.TextFormat.Html) { Text = htmlBody };
        using var smtp = new SmtpClient();
        await smtp.ConnectAsync(_cfg["Email:Host"], int.Parse(_cfg["Email:Port"] ?? "587"), MailKit.Security.SecureSocketOptions.StartTls, ct);
        await smtp.AuthenticateAsync(_cfg["Email:Username"], _cfg["Email:Password"], ct);
        await smtp.SendAsync(email, ct); await smtp.DisconnectAsync(true, ct);
    }
}