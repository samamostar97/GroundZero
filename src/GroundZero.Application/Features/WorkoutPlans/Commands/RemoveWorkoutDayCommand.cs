using GroundZero.Application.Common;
using MediatR;

namespace GroundZero.Application.Features.WorkoutPlans.Commands;

[AuthorizeRole("User")]
public class RemoveWorkoutDayCommand : IRequest<Unit>
{
    public int WorkoutPlanId { get; set; }
    public int DayId { get; set; }
}
