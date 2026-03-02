using GroundZero.Application.Common;
using GroundZero.Application.Features.WorkoutPlans.DTOs;
using MediatR;

namespace GroundZero.Application.Features.WorkoutPlans.Queries;

[AuthorizeRole("User")]
public class GetUserWorkoutPlansQuery : IRequest<PagedResult<WorkoutPlanResponse>>
{
    public int PageNumber { get; set; } = 1;
    public int PageSize { get; set; } = 10;
    public string? Search { get; set; }
}
