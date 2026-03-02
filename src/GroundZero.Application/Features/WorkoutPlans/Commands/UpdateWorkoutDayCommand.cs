using GroundZero.Application.Common;
using GroundZero.Application.Features.WorkoutPlans.DTOs;
using MediatR;

namespace GroundZero.Application.Features.WorkoutPlans.Commands;

[AuthorizeRole("User")]
public class UpdateWorkoutDayCommand : IRequest<WorkoutDayResponse>
{
    public int WorkoutPlanId { get; set; }
    public int DayId { get; set; }
    public UpdateWorkoutDayRequest Request { get; set; } = null!;
}
