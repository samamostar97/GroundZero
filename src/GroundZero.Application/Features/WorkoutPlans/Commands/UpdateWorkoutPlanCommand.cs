using GroundZero.Application.Common;
using GroundZero.Application.Features.WorkoutPlans.DTOs;
using MediatR;

namespace GroundZero.Application.Features.WorkoutPlans.Commands;

[AuthorizeRole("User")]
public class UpdateWorkoutPlanCommand : IRequest<WorkoutPlanResponse>
{
    public int Id { get; set; }
    public UpdateWorkoutPlanRequest Request { get; set; } = null!;
}
