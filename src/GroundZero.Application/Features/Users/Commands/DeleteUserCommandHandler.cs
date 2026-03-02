using GroundZero.Application.Common;
using GroundZero.Application.Exceptions;
using GroundZero.Application.IRepositories;
using GroundZero.Domain.Enums;
using MediatR;

namespace GroundZero.Application.Features.Users.Commands;

public class DeleteUserCommandHandler : IRequestHandler<DeleteUserCommand, ApiResponse<string>>
{
    private readonly IUserRepository _userRepository;

    public DeleteUserCommandHandler(IUserRepository userRepository)
    {
        _userRepository = userRepository;
    }

    public async Task<ApiResponse<string>> Handle(DeleteUserCommand command, CancellationToken cancellationToken)
    {
        var user = await _userRepository.GetByIdAsync(command.Id, cancellationToken)
            ?? throw new NotFoundException("Korisnik", command.Id);

        if (user.Role == Role.Admin)
            return ApiResponse<string>.Fail("Nije moguće obrisati administratora.", 400);

        _userRepository.SoftDelete(user);
        await _userRepository.SaveChangesAsync(cancellationToken);

        return ApiResponse<string>.Success("Korisnik je uspješno obrisan.");
    }
}
