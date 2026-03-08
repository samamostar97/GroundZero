using GroundZero.Application.Features.Users.DTOs;
using MediatR;

namespace GroundZero.Application.Features.Users.Commands;

public class ChangePasswordCommand : IRequest<Unit>
{
    public int UserId { get; set; }
    public ChangePasswordRequest Request { get; set; } = null!;
}
