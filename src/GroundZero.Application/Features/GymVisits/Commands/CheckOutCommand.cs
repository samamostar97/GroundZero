using GroundZero.Application.Common;
using GroundZero.Application.Features.GymVisits.DTOs;
using MediatR;

namespace GroundZero.Application.Features.GymVisits.Commands;

[AuthorizeRole("Admin")]
public class CheckOutCommand : IRequest<GymVisitResponse>
{
    public CheckOutRequest Request { get; set; } = null!;
}
