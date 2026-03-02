using GroundZero.Application.Common;
using GroundZero.Application.Exceptions;
using GroundZero.Application.Features.Staff.DTOs;
using GroundZero.Application.IRepositories;
using MediatR;

namespace GroundZero.Application.Features.Staff.Queries;

public class GetStaffByIdQueryHandler : IRequestHandler<GetStaffByIdQuery, ApiResponse<StaffResponse>>
{
    private readonly IStaffRepository _staffRepository;

    public GetStaffByIdQueryHandler(IStaffRepository staffRepository)
    {
        _staffRepository = staffRepository;
    }

    public async Task<ApiResponse<StaffResponse>> Handle(GetStaffByIdQuery query, CancellationToken cancellationToken)
    {
        var staff = await _staffRepository.GetByIdAsync(query.Id, cancellationToken)
            ?? throw new NotFoundException("Osoblje", query.Id);

        return ApiResponse<StaffResponse>.Success(staff.ToResponse());
    }
}
