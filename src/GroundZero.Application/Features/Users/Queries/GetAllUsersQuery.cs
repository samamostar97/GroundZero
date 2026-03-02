using GroundZero.Application.Common;
using GroundZero.Application.Features.Users.DTOs;
using MediatR;

namespace GroundZero.Application.Features.Users.Queries;

public class GetAllUsersQuery : IRequest<ApiResponse<PagedResult<UserResponse>>>
{
    public int PageNumber { get; set; } = 1;
    public int PageSize { get; set; } = 10;
    public string? Search { get; set; }
}
