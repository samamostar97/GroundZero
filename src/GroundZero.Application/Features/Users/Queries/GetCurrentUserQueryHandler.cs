using GroundZero.Application.Exceptions;
using GroundZero.Application.Features.Users.DTOs;
using GroundZero.Application.IRepositories;
using MediatR;

namespace GroundZero.Application.Features.Users.Queries;

public class GetCurrentUserQueryHandler : IRequestHandler<GetCurrentUserQuery, UserResponse>
{
    private readonly IUserRepository _userRepository;

    public GetCurrentUserQueryHandler(IUserRepository userRepository)
    {
        _userRepository = userRepository;
    }

    public async Task<UserResponse> Handle(GetCurrentUserQuery query, CancellationToken cancellationToken)
    {
        var user = await _userRepository.GetByIdAsync(query.UserId, cancellationToken)
            ?? throw new NotFoundException("Korisnik", query.UserId);

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

        return response;
    }
}
