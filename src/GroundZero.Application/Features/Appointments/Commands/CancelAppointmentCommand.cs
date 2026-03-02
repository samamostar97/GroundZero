using FluentValidation;
using GroundZero.Application.Exceptions;
using GroundZero.Application.Features.Appointments.DTOs;
using GroundZero.Application.IRepositories;
using GroundZero.Application.IServices;
using GroundZero.Domain.Enums;
using MediatR;

namespace GroundZero.Application.Features.Appointments.Commands;

public class CancelAppointmentCommand : IRequest<AppointmentResponse>
{
    public int Id { get; set; }
}

public class CancelAppointmentCommandValidator : AbstractValidator<CancelAppointmentCommand>
{
    public CancelAppointmentCommandValidator()
    {
        RuleFor(x => x.Id)
            .GreaterThan(0).WithMessage("ID termina mora biti veći od 0.");
    }
}

public class CancelAppointmentCommandHandler : IRequestHandler<CancelAppointmentCommand, AppointmentResponse>
{
    private readonly IAppointmentRepository _appointmentRepository;
    private readonly ICurrentUserService _currentUserService;

    public CancelAppointmentCommandHandler(
        IAppointmentRepository appointmentRepository,
        ICurrentUserService currentUserService)
    {
        _appointmentRepository = appointmentRepository;
        _currentUserService = currentUserService;
    }

    public async Task<AppointmentResponse> Handle(CancelAppointmentCommand command, CancellationToken cancellationToken)
    {
        var appointment = await _appointmentRepository.GetByIdWithDetailsAsync(command.Id, cancellationToken)
            ?? throw new NotFoundException("Termin", command.Id);

        var isAdmin = _currentUserService.Role == "Admin";
        var isOwner = appointment.UserId == _currentUserService.UserId;

        if (!isAdmin && !isOwner)
            throw new ForbiddenException();

        if (isAdmin)
        {
            if (appointment.Status == AppointmentStatus.Completed || appointment.Status == AppointmentStatus.Cancelled)
                throw new InvalidOperationException("Nije moguće otkazati termin koji je već završen ili otkazan.");
        }
        else
        {
            if (appointment.Status != AppointmentStatus.Pending && appointment.Status != AppointmentStatus.Confirmed)
                throw new InvalidOperationException("Možete otkazati samo termine sa statusom 'Pending' ili 'Confirmed'.");
        }

        appointment.Status = AppointmentStatus.Cancelled;
        _appointmentRepository.Update(appointment);
        await _appointmentRepository.SaveChangesAsync(cancellationToken);

        return appointment.ToResponse();
    }
}
