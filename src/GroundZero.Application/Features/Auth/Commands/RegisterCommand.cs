using GroundZero.Application.Features.Auth.DTOs;
using MediatR;

namespace GroundZero.Application.Features.Auth.Commands;

public class RegisterCommand : IRequest<AuthResponse>
{
    public RegisterRequest Request { get; set; } = null!;
}
