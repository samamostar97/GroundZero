using GroundZero.Application.Common;
using GroundZero.Application.Features.WorkoutLogs.DTOs;
using MediatR;

namespace GroundZero.Application.Features.WorkoutLogs.Commands;

[AuthorizeRole("User")]
public class CreateWorkoutLogCommand : IRequest<WorkoutLogResponse>
{
    public CreateWorkoutLogRequest Request { get; set; } = null!;
}
