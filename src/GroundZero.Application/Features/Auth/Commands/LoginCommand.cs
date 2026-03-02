using GroundZero.Application.Common;
using GroundZero.Application.Features.Auth.DTOs;
using MediatR;

namespace GroundZero.Application.Features.Auth.Commands;

public class LoginCommand : IRequest<ApiResponse<AuthResponse>>
{
    public LoginRequest Request { get; set; } = null!;
}
