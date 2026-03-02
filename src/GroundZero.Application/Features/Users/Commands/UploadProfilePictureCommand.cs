using GroundZero.Application.Features.Users.DTOs;
using MediatR;

namespace GroundZero.Application.Features.Users.Commands;

public class UploadProfilePictureCommand : IRequest<UserResponse>
{
    public int UserId { get; set; }
    public Stream? FileStream { get; set; }
    public string FileName { get; set; } = string.Empty;
    public long FileSize { get; set; }
}
