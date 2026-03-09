using GroundZero.Application.IServices;
using GroundZero.Messaging.Events;
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
        var message = CreateMessage(toEmail, "Reset lozinke - GroundZero", $@"
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
                <hr style='border:none;border-top:1px solid #eee;margin:20px 0;'/>
                <p style='color:#999;font-size:12px;text-align:center;'>GroundZero Gym Management</p>
            </div>");

        await SendEmailAsync(message, ct);
    }

    public async Task SendOrderConfirmationAsync(string toEmail, int orderId, decimal totalAmount, List<OrderItemInfo> items, CancellationToken ct = default)
    {
        var itemRows = string.Join("", items.Select(i =>
            $"<tr><td style='padding:8px;border-bottom:1px solid #eee;'>{i.ProductName}</td>" +
            $"<td style='padding:8px;border-bottom:1px solid #eee;text-align:center;'>{i.Quantity}</td>" +
            $"<td style='padding:8px;border-bottom:1px solid #eee;text-align:right;'>{i.UnitPrice:F2} KM</td></tr>"));

        var message = CreateMessage(toEmail, "Potvrda narudžbe - GroundZero", $@"
            <div style='font-family: Arial, sans-serif; max-width: 500px; margin: 0 auto; padding: 20px;'>
                <h2 style='color: #333; text-align: center;'>GroundZero</h2>
                <p>Poštovani,</p>
                <p>Vaša narudžba <strong>#{orderId}</strong> je uspješno kreirana.</p>
                <table style='width:100%;border-collapse:collapse;margin:20px 0;'>
                    <tr style='background:#f4f4f4;'>
                        <th style='padding:8px;text-align:left;'>Proizvod</th>
                        <th style='padding:8px;text-align:center;'>Količina</th>
                        <th style='padding:8px;text-align:right;'>Cijena</th>
                    </tr>
                    {itemRows}
                </table>
                <p style='font-size:18px;text-align:right;'><strong>Ukupno: {totalAmount:F2} KM</strong></p>
                <hr style='border:none;border-top:1px solid #eee;margin:20px 0;'/>
                <p style='color:#999;font-size:12px;text-align:center;'>GroundZero Gym Management</p>
            </div>");

        await SendEmailAsync(message, ct);
    }

    public async Task SendOrderStatusChangedAsync(string toEmail, int orderId, string newStatus, CancellationToken ct = default)
    {
        var message = CreateMessage(toEmail, "Promjena statusa narudžbe - GroundZero", $@"
            <div style='font-family: Arial, sans-serif; max-width: 500px; margin: 0 auto; padding: 20px;'>
                <h2 style='color: #333; text-align: center;'>GroundZero</h2>
                <p>Poštovani,</p>
                <p>Status vaše narudžbe <strong>#{orderId}</strong> je promijenjen u: <strong>{newStatus}</strong>.</p>
                <hr style='border:none;border-top:1px solid #eee;margin:20px 0;'/>
                <p style='color:#999;font-size:12px;text-align:center;'>GroundZero Gym Management</p>
            </div>");

        await SendEmailAsync(message, ct);
    }

    public async Task SendAppointmentStatusAsync(string toEmail, string staffName, DateTime scheduledAt, string newStatus, CancellationToken ct = default)
    {
        var message = CreateMessage(toEmail, "Promjena statusa termina - GroundZero", $@"
            <div style='font-family: Arial, sans-serif; max-width: 500px; margin: 0 auto; padding: 20px;'>
                <h2 style='color: #333; text-align: center;'>GroundZero</h2>
                <p>Poštovani,</p>
                <p>Status vašeg termina sa <strong>{staffName}</strong> zakazanog za <strong>{scheduledAt:dd.MM.yyyy HH:mm}</strong> je promijenjen u: <strong>{newStatus}</strong>.</p>
                <hr style='border:none;border-top:1px solid #eee;margin:20px 0;'/>
                <p style='color:#999;font-size:12px;text-align:center;'>GroundZero Gym Management</p>
            </div>");

        await SendEmailAsync(message, ct);
    }

    public async Task SendLevelUpAsync(string toEmail, string userName, int newLevel, CancellationToken ct = default)
    {
        var message = CreateMessage(toEmail, "Novi level! - GroundZero", $@"
            <div style='font-family: Arial, sans-serif; max-width: 500px; margin: 0 auto; padding: 20px;'>
                <h2 style='color: #333; text-align: center;'>GroundZero</h2>
                <p>Čestitamo, <strong>{userName}</strong>!</p>
                <div style='text-align:center;margin:30px 0;'>
                    <span style='font-size:48px;'>🏆</span>
                    <p style='font-size:24px;font-weight:bold;color:#333;'>Level {newLevel}</p>
                </div>
                <p>Nastavite sa treningom i osvajajte još više XP bodova!</p>
                <hr style='border:none;border-top:1px solid #eee;margin:20px 0;'/>
                <p style='color:#999;font-size:12px;text-align:center;'>GroundZero Gym Management</p>
            </div>");

        await SendEmailAsync(message, ct);
    }

    public async Task SendMembershipExpiredAsync(string toEmail, string userName, string planName, DateTime expiredAt, CancellationToken ct = default)
    {
        var message = CreateMessage(toEmail, "Članarina istekla - GroundZero", $@"
            <div style='font-family: Arial, sans-serif; max-width: 500px; margin: 0 auto; padding: 20px;'>
                <h2 style='color: #333; text-align: center;'>GroundZero</h2>
                <p>Poštovani <strong>{userName}</strong>,</p>
                <p>Vaša članarina <strong>{planName}</strong> je istekla dana <strong>{expiredAt:dd.MM.yyyy}</strong>.</p>
                <p>Da biste nastavili koristiti usluge teretane, obnovite svoju članarinu.</p>
                <hr style='border:none;border-top:1px solid #eee;margin:20px 0;'/>
                <p style='color:#999;font-size:12px;text-align:center;'>GroundZero Gym Management</p>
            </div>");

        await SendEmailAsync(message, ct);
    }

    public async Task SendMembershipCancelledAsync(string toEmail, string userName, string planName, DateTime cancelledAt, CancellationToken ct = default)
    {
        var message = CreateMessage(toEmail, "Članarina otkazana - GroundZero", $@"
            <div style='font-family: Arial, sans-serif; max-width: 500px; margin: 0 auto; padding: 20px;'>
                <h2 style='color: #333; text-align: center;'>GroundZero</h2>
                <p>Poštovani <strong>{userName}</strong>,</p>
                <p>Vaša članarina <strong>{planName}</strong> je otkazana dana <strong>{cancelledAt:dd.MM.yyyy}</strong>.</p>
                <p>Za više informacija, kontaktirajte administraciju teretane.</p>
                <hr style='border:none;border-top:1px solid #eee;margin:20px 0;'/>
                <p style='color:#999;font-size:12px;text-align:center;'>GroundZero Gym Management</p>
            </div>");

        await SendEmailAsync(message, ct);
    }

    private MimeMessage CreateMessage(string toEmail, string subject, string htmlBody)
    {
        var message = new MimeMessage();
        message.From.Add(new MailboxAddress("GroundZero", _smtpEmail));
        message.To.Add(new MailboxAddress("", toEmail));
        message.Subject = subject;
        message.Body = new TextPart("html") { Text = htmlBody };
        return message;
    }

    private async Task SendEmailAsync(MimeMessage message, CancellationToken ct)
    {
        using var client = new SmtpClient();
        await client.ConnectAsync(_smtpHost, _smtpPort, MailKit.Security.SecureSocketOptions.StartTls, ct);
        await client.AuthenticateAsync(_smtpEmail, _smtpPassword, ct);
        await client.SendAsync(message, ct);
        await client.DisconnectAsync(true, ct);
    }
}
