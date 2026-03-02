using GroundZero.Application.Common;
using GroundZero.Application.Features.Appointments.DTOs;
using GroundZero.Application.IRepositories;
using GroundZero.Domain.Enums;
using MediatR;

namespace GroundZero.Application.Features.Appointments.Queries;

[AuthorizeRole("Admin")]
public class GetAllAppointmentsQuery : IRequest<PagedResult<AppointmentResponse>>
{
    public int PageNumber { get; set; } = 1;
    public int PageSize { get; set; } = 10;
    public string? Search { get; set; }
    public AppointmentStatus? Status { get; set; }
    public int? StaffId { get; set; }
    public int? UserId { get; set; }
}

public class GetAllAppointmentsQueryHandler : IRequestHandler<GetAllAppointmentsQuery, PagedResult<AppointmentResponse>>
{
    private readonly IAppointmentRepository _appointmentRepository;

    public GetAllAppointmentsQueryHandler(IAppointmentRepository appointmentRepository)
    {
        _appointmentRepository = appointmentRepository;
    }

    public async Task<PagedResult<AppointmentResponse>> Handle(GetAllAppointmentsQuery query, CancellationToken cancellationToken)
    {
        var result = await _appointmentRepository.GetAllAppointmentsPagedAsync(
            query.Search, query.Status, query.StaffId, query.UserId,
            query.PageNumber, query.PageSize, cancellationToken);

        return new PagedResult<AppointmentResponse>
        {
            Items = result.Items.Select(a => a.ToResponse()).ToList(),
            TotalCount = result.TotalCount,
            PageNumber = result.PageNumber,
            PageSize = result.PageSize
        };
    }
}
