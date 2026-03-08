using GroundZero.Application.IRepositories;
using GroundZero.Application.IServices;
using GroundZero.Domain.Entities;
using MediatR;

namespace GroundZero.Application.Features.Auth.Commands;

public class ResetPasswordCommandHandler : IRequestHandler<ResetPasswordCommand, Unit>
{
    private readonly IUserRepository _userRepository;
    private readonly IRepository<PasswordResetToken> _tokenRepository;
    private readonly IPasswordHasher _passwordHasher;

    public ResetPasswordCommandHandler(
        IUserRepository userRepository,
        IRepository<PasswordResetToken> tokenRepository,
        IPasswordHasher passwordHasher)
    {
        _userRepository = userRepository;
        _tokenRepository = tokenRepository;
        _passwordHasher = passwordHasher;
    }

    public async Task<Unit> Handle(ResetPasswordCommand command, CancellationToken cancellationToken)
    {
        var request = command.Request;

        var user = await _userRepository.GetByEmailAsync(request.Email.ToLower(), cancellationToken);
        if (user == null)
            throw new InvalidOperationException("Kod za reset lozinke nije ispravan ili je istekao.");

        var tokens = await _tokenRepository.FindAsync(
            t => t.UserId == user.Id
                 && t.Code == request.Code
                 && !t.IsUsed
                 && t.ExpiresAt > DateTime.UtcNow,
            cancellationToken);

        var token = tokens.OrderByDescending(t => t.CreatedAt).FirstOrDefault();

        if (token == null)
            throw new InvalidOperationException("Kod za reset lozinke nije ispravan ili je istekao.");

        user.PasswordHash = _passwordHasher.Hash(request.NewPassword);
        _userRepository.Update(user);

        token.IsUsed = true;
        _tokenRepository.Update(token);

        await _tokenRepository.SaveChangesAsync(cancellationToken);

        return Unit.Value;
    }
}
