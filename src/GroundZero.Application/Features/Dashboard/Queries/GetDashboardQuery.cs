using GroundZero.Application.Common;
using GroundZero.Application.Features.Dashboard.DTOs;
using MediatR;

namespace GroundZero.Application.Features.Dashboard.Queries;

[AuthorizeRole("Admin")]
public class GetDashboardQuery : IRequest<DashboardResponse>
{
}
