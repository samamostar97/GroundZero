using GroundZero.Application.Common;
using GroundZero.Application.Exceptions;
using GroundZero.Application.Features.Staff.DTOs;
using GroundZero.Application.IRepositories;
using GroundZero.Domain.Enums;
using MediatR;

namespace GroundZero.Application.Features.Staff.Commands;

public class CreateStaffCommandHandler : IRequestHandler<CreateStaffCommand, ApiResponse<StaffResponse>>
{
    private readonly IStaffRepository _staffRepository;

    public CreateStaffCommandHandler(IStaffRepository staffRepository)
    {
        _staffRepository = staffRepository;
    }

    public async Task<ApiResponse<StaffResponse>> Handle(CreateStaffCommand command, CancellationToken cancellationToken)
    {
        var request = command.Request;

        if (await _staffRepository.EmailExistsAsync(request.Email, cancellationToken: cancellationToken))
            throw new ConflictException("Osoblje sa navedenim emailom već postoji.");

        var staff = new Domain.Entities.Staff
        {
            FirstName = request.FirstName,
            LastName = request.LastName,
            Email = request.Email.ToLower(),
            Phone = request.Phone,
            Bio = request.Bio,
            StaffType = Enum.Parse<StaffType>(request.StaffType)
        };

        await _staffRepository.AddAsync(staff, cancellationToken);
        await _staffRepository.SaveChangesAsync(cancellationToken);

        return ApiResponse<StaffResponse>.Success(staff.ToResponse(), 201);
    }
}
