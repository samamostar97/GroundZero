using GroundZero.Application.Features.Auth.DTOs;
using MediatR;

namespace GroundZero.Application.Features.Auth.Commands;

public class ResetPasswordCommand : IRequest<Unit>
{
    public ResetPasswordRequest Request { get; set; } = null!;
}
