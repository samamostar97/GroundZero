using GroundZero.Application.Common;
using GroundZero.Application.Exceptions;
using GroundZero.Application.Features.Users.DTOs;
using GroundZero.Application.IRepositories;
using GroundZero.Application.IServices;
using MediatR;

namespace GroundZero.Application.Features.Users.Commands;

public class UploadProfilePictureCommandHandler : IRequestHandler<UploadProfilePictureCommand, ApiResponse<UserResponse>>
{
    private readonly IUserRepository _userRepository;
    private readonly IFileService _fileService;

    public UploadProfilePictureCommandHandler(IUserRepository userRepository, IFileService fileService)
    {
        _userRepository = userRepository;
        _fileService = fileService;
    }

    public async Task<ApiResponse<UserResponse>> Handle(UploadProfilePictureCommand command, CancellationToken cancellationToken)
    {
        var user = await _userRepository.GetByIdAsync(command.UserId, cancellationToken)
            ?? throw new NotFoundException("Korisnik", command.UserId);

        if (!string.IsNullOrEmpty(user.ProfileImageUrl))
            _fileService.DeleteFile(user.ProfileImageUrl);

        var imageUrl = await _fileService.UploadFileAsync(command.FileStream, command.FileName, "profiles");
        user.ProfileImageUrl = imageUrl;

        _userRepository.Update(user);
        await _userRepository.SaveChangesAsync(cancellationToken);

        var response = new UserResponse
        {
            Id = user.Id,
            FirstName = user.FirstName,
            LastName = user.LastName,
            Email = user.Email,
            ProfileImageUrl = user.ProfileImageUrl,
            Role = user.Role.ToString(),
            Level = user.Level,
            XP = user.XP,
            TotalGymMinutes = user.TotalGymMinutes,
            CreatedAt = user.CreatedAt
        };

        return ApiResponse<UserResponse>.Success(response);
    }
}
