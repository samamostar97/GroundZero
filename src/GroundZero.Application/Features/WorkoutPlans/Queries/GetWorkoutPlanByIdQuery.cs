using GroundZero.Application.Common;
using GroundZero.Application.Features.WorkoutPlans.DTOs;
using MediatR;

namespace GroundZero.Application.Features.WorkoutPlans.Queries;

[AuthorizeRole("User")]
public class GetWorkoutPlanByIdQuery : IRequest<WorkoutPlanResponse>
{
    public int Id { get; set; }
}
