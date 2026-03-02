using GroundZero.Application.Exceptions;
using GroundZero.Application.Features.Appointments.DTOs;
using GroundZero.Application.IRepositories;
using GroundZero.Application.IServices;
using MediatR;

namespace GroundZero.Application.Features.Appointments.Queries;

public class GetAppointmentByIdQuery : IRequest<AppointmentResponse>
{
    public int Id { get; set; }
}

public class GetAppointmentByIdQueryHandler : IRequestHandler<GetAppointmentByIdQuery, AppointmentResponse>
{
    private readonly IAppointmentRepository _appointmentRepository;
    private readonly ICurrentUserService _currentUserService;

    public GetAppointmentByIdQueryHandler(
        IAppointmentRepository appointmentRepository,
        ICurrentUserService currentUserService)
    {
        _appointmentRepository = appointmentRepository;
        _currentUserService = currentUserService;
    }

    public async Task<AppointmentResponse> Handle(GetAppointmentByIdQuery query, CancellationToken cancellationToken)
    {
        var appointment = await _appointmentRepository.GetByIdWithDetailsAsync(query.Id, cancellationToken)
            ?? throw new NotFoundException("Termin", query.Id);

        var isAdmin = _currentUserService.Role == "Admin";
        var isOwner = appointment.UserId == _currentUserService.UserId;

        if (!isAdmin && !isOwner)
            throw new ForbiddenException();

        return appointment.ToResponse();
    }
}
