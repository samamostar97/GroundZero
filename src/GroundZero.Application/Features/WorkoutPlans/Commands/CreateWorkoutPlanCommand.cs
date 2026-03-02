using GroundZero.Application.Common;
using GroundZero.Application.Features.WorkoutPlans.DTOs;
using MediatR;

namespace GroundZero.Application.Features.WorkoutPlans.Commands;

[AuthorizeRole("User")]
public class CreateWorkoutPlanCommand : IRequest<WorkoutPlanResponse>
{
    public CreateWorkoutPlanRequest Request { get; set; } = null!;
}
