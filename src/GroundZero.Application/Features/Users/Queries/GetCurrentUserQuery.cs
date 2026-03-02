using GroundZero.Application.Features.Users.DTOs;
using MediatR;

namespace GroundZero.Application.Features.Users.Queries;

public class GetCurrentUserQuery : IRequest<UserResponse>
{
    public int UserId { get; set; }
}
