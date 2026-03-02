using GroundZero.Application.Common;
using GroundZero.Application.Exceptions;
using GroundZero.Application.Features.Staff.DTOs;
using GroundZero.Application.IRepositories;
using GroundZero.Application.IServices;
using MediatR;

namespace GroundZero.Application.Features.Staff.Commands;

public class UploadStaffPictureCommandHandler : IRequestHandler<UploadStaffPictureCommand, ApiResponse<StaffResponse>>
{
    private readonly IStaffRepository _staffRepository;
    private readonly IFileService _fileService;

    public UploadStaffPictureCommandHandler(IStaffRepository staffRepository, IFileService fileService)
    {
        _staffRepository = staffRepository;
        _fileService = fileService;
    }

    public async Task<ApiResponse<StaffResponse>> Handle(UploadStaffPictureCommand command, CancellationToken cancellationToken)
    {
        var staff = await _staffRepository.GetByIdAsync(command.Id, cancellationToken)
            ?? throw new NotFoundException("Osoblje", command.Id);

        if (!string.IsNullOrEmpty(staff.ProfileImageUrl))
            _fileService.DeleteFile(staff.ProfileImageUrl);

        var imageUrl = await _fileService.UploadFileAsync(command.FileStream, command.FileName, "staff");
        staff.ProfileImageUrl = imageUrl;

        _staffRepository.Update(staff);
        await _staffRepository.SaveChangesAsync(cancellationToken);

        return ApiResponse<StaffResponse>.Success(staff.ToResponse());
    }
}
