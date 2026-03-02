using MediatR;

namespace GroundZero.Application.Features.Auth.Commands;

public class LogoutCommand : IRequest<Unit>
{
    public int UserId { get; set; }
}
