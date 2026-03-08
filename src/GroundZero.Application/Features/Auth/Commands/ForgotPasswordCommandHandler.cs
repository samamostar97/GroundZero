using GroundZero.Application.IRepositories;
using GroundZero.Application.IServices;
using GroundZero.Domain.Entities;
using MediatR;

namespace GroundZero.Application.Features.Auth.Commands;

public class ForgotPasswordCommandHandler : IRequestHandler<ForgotPasswordCommand, Unit>
{
    private readonly IUserRepository _userRepository;
    private readonly IRepository<PasswordResetToken> _tokenRepository;
    private readonly IEmailService _emailService;

    public ForgotPasswordCommandHandler(
        IUserRepository userRepository,
        IRepository<PasswordResetToken> tokenRepository,
        IEmailService emailService)
    {
        _userRepository = userRepository;
        _tokenRepository = tokenRepository;
        _emailService = emailService;
    }

    public async Task<Unit> Handle(ForgotPasswordCommand command, CancellationToken cancellationToken)
    {
        var user = await _userRepository.GetByEmailAsync(command.Request.Email.ToLower(), cancellationToken);

        // Security: don't reveal if email exists
        if (user == null)
            return Unit.Value;

        var code = Random.Shared.Next(1000, 9999).ToString();

        var token = new PasswordResetToken
        {
            UserId = user.Id,
            Code = code,
            ExpiresAt = DateTime.UtcNow.AddMinutes(15),
            IsUsed = false
        };

        await _tokenRepository.AddAsync(token, cancellationToken);
        await _tokenRepository.SaveChangesAsync(cancellationToken);

        await _emailService.SendPasswordResetCodeAsync(user.Email, code, cancellationToken);

        return Unit.Value;
    }
}
