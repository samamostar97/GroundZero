using GroundZero.Application.Common;
using GroundZero.Application.Features.Users.DTOs;
using MediatR;

namespace GroundZero.Application.Features.Users.Queries;

[AuthorizeRole("User")]
public class GetMyGamificationQuery : IRequest<GamificationResponse>
{
}
