using GroundZero.Application.Common;
using GroundZero.Application.Features.Users.DTOs;
using MediatR;

namespace GroundZero.Application.Features.Users.Commands;

public class UploadProfilePictureCommand : IRequest<ApiResponse<UserResponse>>
{
    public int UserId { get; set; }
    public Stream FileStream { get; set; } = null!;
    public string FileName { get; set; } = string.Empty;
}
