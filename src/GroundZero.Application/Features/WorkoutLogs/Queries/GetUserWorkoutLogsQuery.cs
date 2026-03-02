using GroundZero.Application.Common;
using GroundZero.Application.Features.WorkoutLogs.DTOs;
using MediatR;

namespace GroundZero.Application.Features.WorkoutLogs.Queries;

[AuthorizeRole("User")]
public class GetUserWorkoutLogsQuery : IRequest<PagedResult<WorkoutLogResponse>>
{
    public int PageNumber { get; set; } = 1;
    public int PageSize { get; set; } = 10;
}
