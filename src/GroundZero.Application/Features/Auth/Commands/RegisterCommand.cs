using GroundZero.Application.Common;
using GroundZero.Application.Features.Auth.DTOs;
using MediatR;

namespace GroundZero.Application.Features.Auth.Commands;

public class RegisterCommand : IRequest<ApiResponse<AuthResponse>>
{
    public RegisterRequest Request { get; set; } = null!;
}
