using GroundZero.Application.Common;
using GroundZero.Application.Features.Auth.DTOs;
using MediatR;

namespace GroundZero.Application.Features.Auth.Commands;

public class RefreshTokenCommand : IRequest<ApiResponse<AuthResponse>>
{
    public RefreshTokenRequest Request { get; set; } = null!;
}
