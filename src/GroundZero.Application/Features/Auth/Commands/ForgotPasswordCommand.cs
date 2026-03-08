using GroundZero.Application.Features.Auth.DTOs;
using MediatR;

namespace GroundZero.Application.Features.Auth.Commands;

public class ForgotPasswordCommand : IRequest<Unit>
{
    public ForgotPasswordRequest Request { get; set; } = null!;
}
