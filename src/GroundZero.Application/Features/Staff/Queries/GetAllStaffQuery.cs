using GroundZero.Application.Common;
using GroundZero.Application.Features.Staff.DTOs;
using GroundZero.Domain.Enums;
using MediatR;

namespace GroundZero.Application.Features.Staff.Queries;

public class GetAllStaffQuery : IRequest<PagedResult<StaffResponse>>
{
    public int PageNumber { get; set; } = 1;
    public int PageSize { get; set; } = 10;
    public string? Search { get; set; }
    public StaffType? StaffType { get; set; }
    public string? SortBy { get; set; }
    public bool SortDescending { get; set; } = true;
}
