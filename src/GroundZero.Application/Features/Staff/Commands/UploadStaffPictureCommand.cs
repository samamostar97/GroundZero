using GroundZero.Application.Common;
using GroundZero.Application.Features.Staff.DTOs;
using MediatR;

namespace GroundZero.Application.Features.Staff.Commands;

public class UploadStaffPictureCommand : IRequest<ApiResponse<StaffResponse>>
{
    public int Id { get; set; }
    public Stream FileStream { get; set; } = null!;
    public string FileName { get; set; } = string.Empty;
}
