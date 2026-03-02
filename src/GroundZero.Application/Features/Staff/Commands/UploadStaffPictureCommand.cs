using GroundZero.Application.Common;
using GroundZero.Application.Features.Staff.DTOs;
using MediatR;

namespace GroundZero.Application.Features.Staff.Commands;

[AuthorizeRole("Admin")]
public class UploadStaffPictureCommand : IRequest<StaffResponse>
{
    public int Id { get; set; }
    public Stream? FileStream { get; set; }
    public string FileName { get; set; } = string.Empty;
    public long FileSize { get; set; }
}
