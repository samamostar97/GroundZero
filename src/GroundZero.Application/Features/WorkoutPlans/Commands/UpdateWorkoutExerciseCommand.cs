using GroundZero.Application.Common;
using GroundZero.Application.Features.WorkoutPlans.DTOs;
using MediatR;

namespace GroundZero.Application.Features.WorkoutPlans.Commands;

[AuthorizeRole("User")]
public class UpdateWorkoutExerciseCommand : IRequest<WorkoutExerciseResponse>
{
    public int WorkoutPlanId { get; set; }
    public int DayId { get; set; }
    public int ExerciseId { get; set; }
    public UpdateWorkoutExerciseRequest Request { get; set; } = null!;
}
