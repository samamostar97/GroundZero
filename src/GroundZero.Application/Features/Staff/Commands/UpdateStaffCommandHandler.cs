using GroundZero.Application.Common;
using GroundZero.Application.Exceptions;
using GroundZero.Application.Features.Staff.DTOs;
using GroundZero.Application.IRepositories;
using GroundZero.Domain.Enums;
using MediatR;

namespace GroundZero.Application.Features.Staff.Commands;

public class UpdateStaffCommandHandler : IRequestHandler<UpdateStaffCommand, ApiResponse<StaffResponse>>
{
    private readonly IStaffRepository _staffRepository;

    public UpdateStaffCommandHandler(IStaffRepository staffRepository)
    {
        _staffRepository = staffRepository;
    }

    public async Task<ApiResponse<StaffResponse>> Handle(UpdateStaffCommand command, CancellationToken cancellationToken)
    {
        var staff = await _staffRepository.GetByIdAsync(command.Id, cancellationToken)
            ?? throw new NotFoundException("Osoblje", command.Id);

        var request = command.Request;

        if (await _staffRepository.EmailExistsAsync(request.Email, command.Id, cancellationToken))
            throw new ConflictException("Osoblje sa navedenim emailom već postoji.");

        staff.FirstName = request.FirstName;
        staff.LastName = request.LastName;
        staff.Email = request.Email.ToLower();
        staff.Phone = request.Phone;
        staff.Bio = request.Bio;
        staff.StaffType = Enum.Parse<StaffType>(request.StaffType);
        staff.IsActive = request.IsActive;

        _staffRepository.Update(staff);
        await _staffRepository.SaveChangesAsync(cancellationToken);

        return ApiResponse<StaffResponse>.Success(staff.ToResponse());
    }
}
