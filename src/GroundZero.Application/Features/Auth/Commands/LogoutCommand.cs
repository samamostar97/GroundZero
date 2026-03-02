using GroundZero.Application.Common;
using MediatR;

namespace GroundZero.Application.Features.Auth.Commands;

public class LogoutCommand : IRequest<ApiResponse<string>>
{
    public int UserId { get; set; }
}
