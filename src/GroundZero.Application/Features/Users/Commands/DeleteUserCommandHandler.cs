using GroundZero.Application.Exceptions;
using GroundZero.Application.IRepositories;
using GroundZero.Domain.Enums;
using MediatR;

namespace GroundZero.Application.Features.Users.Commands;

public class DeleteUserCommandHandler : IRequestHandler<DeleteUserCommand, Unit>
{
    private readonly IUserRepository _userRepository;

    public DeleteUserCommandHandler(IUserRepository userRepository)
    {
        _userRepository = userRepository;
    }

    public async Task<Unit> Handle(DeleteUserCommand command, CancellationToken cancellationToken)
    {
        var user = await _userRepository.GetByIdAsync(command.Id, cancellationToken)
            ?? throw new NotFoundException("Korisnik", command.Id);

        if (user.Role == Role.Admin)
            throw new InvalidOperationException("Nije moguće obrisati administratora.");

        _userRepository.SoftDelete(user);
        await _userRepository.SaveChangesAsync(cancellationToken);

        return Unit.Value;
    }
}
