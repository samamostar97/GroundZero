using GroundZero.Application.Common;
using GroundZero.Application.Features.Users.DTOs;
using MediatR;

namespace GroundZero.Application.Features.Users.Queries;

public class GetUserByIdQuery : IRequest<ApiResponse<UserResponse>>
{
    public int Id { get; set; }
}
