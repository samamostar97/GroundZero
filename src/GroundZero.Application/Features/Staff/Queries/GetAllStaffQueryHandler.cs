using GroundZero.Application.Common;
using GroundZero.Application.Features.Staff.DTOs;
using GroundZero.Application.IRepositories;
using MediatR;

namespace GroundZero.Application.Features.Staff.Queries;

public class GetAllStaffQueryHandler : IRequestHandler<GetAllStaffQuery, ApiResponse<PagedResult<StaffResponse>>>
{
    private readonly IStaffRepository _staffRepository;

    public GetAllStaffQueryHandler(IStaffRepository staffRepository)
    {
        _staffRepository = staffRepository;
    }

    public async Task<ApiResponse<PagedResult<StaffResponse>>> Handle(GetAllStaffQuery query, CancellationToken cancellationToken)
    {
        var pagedStaff = await _staffRepository.GetPagedAsync(query.Search, query.StaffType, query.PageNumber, query.PageSize, cancellationToken);

        var result = new PagedResult<StaffResponse>
        {
            Items = pagedStaff.Items.Select(s => s.ToResponse()).ToList(),
            TotalCount = pagedStaff.TotalCount,
            PageNumber = pagedStaff.PageNumber,
            PageSize = pagedStaff.PageSize
        };

        return ApiResponse<PagedResult<StaffResponse>>.Success(result);
    }
}
