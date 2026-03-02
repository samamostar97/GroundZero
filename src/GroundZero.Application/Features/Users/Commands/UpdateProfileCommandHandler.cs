using GroundZero.Application.Common;
using GroundZero.Application.Exceptions;
using GroundZero.Application.Features.Users.DTOs;
using GroundZero.Application.IRepositories;
using MediatR;

namespace GroundZero.Application.Features.Users.Commands;

public class UpdateProfileCommandHandler : IRequestHandler<UpdateProfileCommand, ApiResponse<UserResponse>>
{
    private readonly IUserRepository _userRepository;

    public UpdateProfileCommandHandler(IUserRepository userRepository)
    {
        _userRepository = userRepository;
    }

    public async Task<ApiResponse<UserResponse>> Handle(UpdateProfileCommand command, CancellationToken cancellationToken)
    {
        var user = await _userRepository.GetByIdAsync(command.UserId, cancellationToken)
            ?? throw new NotFoundException("Korisnik", command.UserId);

        user.FirstName = command.Request.FirstName;
        user.LastName = command.Request.LastName;

        _userRepository.Update(user);
        await _userRepository.SaveChangesAsync(cancellationToken);

        var response = new UserResponse
        {
            Id = user.Id,
            FirstName = user.FirstName,
            LastName = user.LastName,
            Email = user.Email,
            ProfileImageUrl = user.ProfileImageUrl,
            Role = user.Role.ToString(),
            Level = user.Level,
            XP = user.XP,
            TotalGymMinutes = user.TotalGymMinutes,
            CreatedAt = user.CreatedAt
        };

        return ApiResponse<UserResponse>.Success(response);
    }
}
