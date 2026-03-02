using GroundZero.Application.Common;
using GroundZero.Application.Features.Users.DTOs;
using MediatR;

namespace GroundZero.Application.Features.Users.Queries;

[AuthorizeRole("Admin")]
public class GetUserByIdQuery : IRequest<UserResponse>
{
    public int Id { get; set; }
}
