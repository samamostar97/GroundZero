using GroundZero.Application.Common;
using GroundZero.Application.Features.GymVisits.DTOs;
using MediatR;

namespace GroundZero.Application.Features.GymVisits.Commands;

[AuthorizeRole("Admin")]
public class CheckInCommand : IRequest<GymVisitResponse>
{
    public CheckInRequest Request { get; set; } = null!;
}
