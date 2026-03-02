using GroundZero.Application.Common;
using MediatR;

namespace GroundZero.Application.Features.Users.Commands;

public class DeleteUserCommand : IRequest<ApiResponse<string>>
{
    public int Id { get; set; }
}
