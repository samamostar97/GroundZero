using GroundZero.Application.Common;
using GroundZero.Application.Features.WorkoutLogs.DTOs;
using MediatR;

namespace GroundZero.Application.Features.WorkoutLogs.Queries;

[AuthorizeRole("User")]
public class GetWorkoutLogByIdQuery : IRequest<WorkoutLogResponse>
{
    public int Id { get; set; }
}
