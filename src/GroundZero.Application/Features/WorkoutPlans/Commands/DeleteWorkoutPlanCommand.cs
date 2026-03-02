using GroundZero.Application.Common;
using MediatR;

namespace GroundZero.Application.Features.WorkoutPlans.Commands;

[AuthorizeRole("User")]
public class DeleteWorkoutPlanCommand : IRequest<Unit>
{
    public int Id { get; set; }
}
