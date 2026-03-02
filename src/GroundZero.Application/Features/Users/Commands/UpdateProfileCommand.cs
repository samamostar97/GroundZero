using GroundZero.Application.Features.Users.DTOs;
using MediatR;

namespace GroundZero.Application.Features.Users.Commands;

public class UpdateProfileCommand : IRequest<UserResponse>
{
    public int UserId { get; set; }
    public UpdateProfileRequest Request { get; set; } = null!;
}
