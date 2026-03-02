using GroundZero.Application.Common;
using GroundZero.Application.Exceptions;
using GroundZero.Application.IRepositories;
using MediatR;

namespace GroundZero.Application.Features.Staff.Commands;

public class DeleteStaffCommandHandler : IRequestHandler<DeleteStaffCommand, ApiResponse<string>>
{
    private readonly IStaffRepository _staffRepository;

    public DeleteStaffCommandHandler(IStaffRepository staffRepository)
    {
        _staffRepository = staffRepository;
    }

    public async Task<ApiResponse<string>> Handle(DeleteStaffCommand command, CancellationToken cancellationToken)
    {
        var staff = await _staffRepository.GetByIdAsync(command.Id, cancellationToken)
            ?? throw new NotFoundException("Osoblje", command.Id);

        _staffRepository.SoftDelete(staff);
        await _staffRepository.SaveChangesAsync(cancellationToken);

        return ApiResponse<string>.Success("Osoblje je uspješno obrisano.");
    }
}
