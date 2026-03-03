using GroundZero.Application.Common;
using GroundZero.Application.Features.Memberships.DTOs;
using MediatR;

namespace GroundZero.Application.Features.Memberships.Queries;

[AuthorizeRole("User")]
public class GetMyMembershipQuery : IRequest<UserMembershipResponse?>
{
}
