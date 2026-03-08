using GroundZero.Application.Exceptions;
using GroundZero.Application.IRepositories;
using GroundZero.Application.IServices;
using MediatR;

namespace GroundZero.Application.Features.Users.Commands;

public class ChangePasswordCommandHandler : IRequestHandler<ChangePasswordCommand, Unit>
{
    private readonly IUserRepository _userRepository;
    private readonly IPasswordHasher _passwordHasher;

    public ChangePasswordCommandHandler(IUserRepository userRepository, IPasswordHasher passwordHasher)
    {
        _userRepository = userRepository;
        _passwordHasher = passwordHasher;
    }

    public async Task<Unit> Handle(ChangePasswordCommand command, CancellationToken cancellationToken)
    {
        var user = await _userRepository.GetByIdAsync(command.UserId, cancellationToken)
            ?? throw new NotFoundException("Korisnik", command.UserId);

        if (!_passwordHasher.Verify(command.Request.CurrentPassword, user.PasswordHash))
            throw new InvalidOperationException("Trenutna lozinka nije ispravna.");

        user.PasswordHash = _passwordHasher.Hash(command.Request.NewPassword);

        _userRepository.Update(user);
        await _userRepository.SaveChangesAsync(cancellationToken);

        return Unit.Value;
    }
}
