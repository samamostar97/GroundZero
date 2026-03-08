using FluentValidation;
using GroundZero.Application.Common;
using GroundZero.Application.Exceptions;
using GroundZero.Application.Features.Appointments.DTOs;
using GroundZero.Application.IRepositories;
using GroundZero.Domain.Enums;
using GroundZero.Messaging;
using GroundZero.Messaging.Events;
using MediatR;

namespace GroundZero.Application.Features.Appointments.Commands;

[AuthorizeRole("Admin")]
public class UpdateAppointmentStatusCommand : IRequest<AppointmentResponse>
{
    public int Id { get; set; }
    public UpdateAppointmentStatusRequest Request { get; set; } = null!;
}

public class UpdateAppointmentStatusCommandValidator : AbstractValidator<UpdateAppointmentStatusCommand>
{
    public UpdateAppointmentStatusCommandValidator()
    {
        RuleFor(x => x.Id)
            .GreaterThan(0).WithMessage("ID termina mora biti veći od 0.");

        RuleFor(x => x.Request.Status)
            .IsInEnum().WithMessage("Nevažeći status termina.");
    }
}

public class UpdateAppointmentStatusCommandHandler : IRequestHandler<UpdateAppointmentStatusCommand, AppointmentResponse>
{
    private readonly IAppointmentRepository _appointmentRepository;
    private readonly IMessagePublisher _messagePublisher;

    public UpdateAppointmentStatusCommandHandler(
        IAppointmentRepository appointmentRepository,
        IMessagePublisher messagePublisher)
    {
        _appointmentRepository = appointmentRepository;
        _messagePublisher = messagePublisher;
    }

    public async Task<AppointmentResponse> Handle(UpdateAppointmentStatusCommand command, CancellationToken cancellationToken)
    {
        var appointment = await _appointmentRepository.GetByIdWithDetailsAsync(command.Id, cancellationToken)
            ?? throw new NotFoundException("Termin", command.Id);

        ValidateStatusTransition(appointment.Status, command.Request.Status);

        appointment.Status = command.Request.Status;
        _appointmentRepository.Update(appointment);
        await _appointmentRepository.SaveChangesAsync(cancellationToken);

        await _messagePublisher.PublishAsync(QueueNames.AppointmentStatusChanged, new AppointmentStatusChangedEvent
        {
            Email = appointment.User.Email,
            StaffName = $"{appointment.Staff.FirstName} {appointment.Staff.LastName}",
            ScheduledAt = appointment.ScheduledAt,
            NewStatus = command.Request.Status.ToString()
        }, cancellationToken);

        return appointment.ToResponse();
    }

    private static void ValidateStatusTransition(AppointmentStatus current, AppointmentStatus target)
    {
        var allowed = current switch
        {
            AppointmentStatus.Pending => new[] { AppointmentStatus.Confirmed, AppointmentStatus.Cancelled },
            AppointmentStatus.Confirmed => new[] { AppointmentStatus.Completed, AppointmentStatus.Cancelled },
            AppointmentStatus.Completed => Array.Empty<AppointmentStatus>(),
            AppointmentStatus.Cancelled => Array.Empty<AppointmentStatus>(),
            _ => Array.Empty<AppointmentStatus>()
        };

        if (!allowed.Contains(target))
            throw new InvalidOperationException($"Nije moguće promijeniti status sa '{current}' na '{target}'.");
    }
}
