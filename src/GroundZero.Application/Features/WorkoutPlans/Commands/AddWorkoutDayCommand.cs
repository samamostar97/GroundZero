using GroundZero.Application.Common;
using GroundZero.Application.Features.WorkoutPlans.DTOs;
using MediatR;

namespace GroundZero.Application.Features.WorkoutPlans.Commands;

[AuthorizeRole("User")]
public class AddWorkoutDayCommand : IRequest<WorkoutDayResponse>
{
    public int WorkoutPlanId { get; set; }
    public AddWorkoutDayRequest Request { get; set; } = null!;
}
