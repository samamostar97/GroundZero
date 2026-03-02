using GroundZero.Application.Exceptions;
using GroundZero.Application.Features.Users.DTOs;
using GroundZero.Application.IRepositories;
using MediatR;

namespace GroundZero.Application.Features.Users.Queries;

public class GetUserByIdQueryHandler : IRequestHandler<GetUserByIdQuery, UserResponse>
{
    private readonly IUserRepository _userRepository;

    public GetUserByIdQueryHandler(IUserRepository userRepository)
    {
        _userRepository = userRepository;
    }

    public async Task<UserResponse> Handle(GetUserByIdQuery query, CancellationToken cancellationToken)
    {
        var user = await _userRepository.GetByIdAsync(query.Id, cancellationToken)
            ?? throw new NotFoundException("Korisnik", query.Id);

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
