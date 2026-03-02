using GroundZero.Application.Common;
using MediatR;

namespace GroundZero.Application.Features.Users.Commands;

[AuthorizeRole("Admin")]
public class DeleteUserCommand : IRequest<Unit>
{
    public int Id { get; set; }
}
