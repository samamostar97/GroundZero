using GroundZero.Application.Common;
using GroundZero.Application.Features.Appointments.DTOs;
using GroundZero.Application.IRepositories;
using GroundZero.Application.IServices;
using GroundZero.Domain.Enums;
using MediatR;

namespace GroundZero.Application.Features.Appointments.Queries;

[AuthorizeRole("User")]
public class GetUserAppointmentsQuery : IRequest<PagedResult<AppointmentResponse>>
{
    public int PageNumber { get; set; } = 1;
    public int PageSize { get; set; } = 10;
    public AppointmentStatus? Status { get; set; }
}

public class GetUserAppointmentsQueryHandler : IRequestHandler<GetUserAppointmentsQuery, PagedResult<AppointmentResponse>>
{
    private readonly IAppointmentRepository _appointmentRepository;
    private readonly ICurrentUserService _currentUserService;

    public GetUserAppointmentsQueryHandler(
        IAppointmentRepository appointmentRepository,
        ICurrentUserService currentUserService)
    {
        _appointmentRepository = appointmentRepository;
        _currentUserService = currentUserService;
    }

    public async Task<PagedResult<AppointmentResponse>> Handle(GetUserAppointmentsQuery query, CancellationToken cancellationToken)
    {
        var userId = _currentUserService.UserId
            ?? throw new UnauthorizedAccessException("Morate biti prijavljeni.");

        var result = await _appointmentRepository.GetUserAppointmentsPagedAsync(
            userId, query.Status, query.PageNumber, query.PageSize, cancellationToken);

        return new PagedResult<AppointmentResponse>
        {
            Items = result.Items.Select(a => a.ToResponse()).ToList(),
            TotalCount = result.TotalCount,
            PageNumber = result.PageNumber,
            PageSize = result.PageSize
        };
    }
}
