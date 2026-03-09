using FluentValidation;
using GroundZero.Application.Common;
using GroundZero.Application.Exceptions;
using GroundZero.Application.Features.Appointments.DTOs;
using GroundZero.Application.IRepositories;
using GroundZero.Application.IServices;
using GroundZero.Domain.Entities;
using MediatR;

namespace GroundZero.Application.Features.Appointments.Commands;

[AuthorizeRole("User")]
public class CreateAppointmentCommand : IRequest<AppointmentResponse>
{
    public CreateAppointmentRequest Request { get; set; } = null!;
}

public class CreateAppointmentCommandValidator : AbstractValidator<CreateAppointmentCommand>
{
    public CreateAppointmentCommandValidator()
    {
        RuleFor(x => x.Request.StaffId)
            .GreaterThan(0).WithMessage("StaffId mora biti veći od 0.");

        RuleFor(x => x.Request.ScheduledAt)
            .GreaterThan(DateTime.UtcNow).WithMessage("Termin mora biti zakazan u budućnosti.");

        RuleFor(x => x.Request.Notes)
            .MaximumLength(1000).WithMessage("Napomena ne može biti duža od 1000 karaktera.");
    }
}

public class CreateAppointmentCommandHandler : IRequestHandler<CreateAppointmentCommand, AppointmentResponse>
{
    private readonly IAppointmentRepository _appointmentRepository;
    private readonly IStaffRepository _staffRepository;
    private readonly ICurrentUserService _currentUserService;
    private readonly IUserRepository _userRepository;

    public CreateAppointmentCommandHandler(
        IAppointmentRepository appointmentRepository,
        IStaffRepository staffRepository,
        ICurrentUserService currentUserService,
        IUserRepository userRepository)
    {
        _appointmentRepository = appointmentRepository;
        _staffRepository = staffRepository;
        _currentUserService = currentUserService;
        _userRepository = userRepository;
    }

    public async Task<AppointmentResponse> Handle(CreateAppointmentCommand command, CancellationToken cancellationToken)
    {
        var userId = _currentUserService.UserId
            ?? throw new UnauthorizedAccessException("Morate biti prijavljeni.");

        var staff = await _staffRepository.GetByIdAsync(command.Request.StaffId, cancellationToken)
            ?? throw new NotFoundException("Osoblje", command.Request.StaffId);

        if (!staff.IsActive)
            throw new InvalidOperationException("Odabrano osoblje trenutno nije aktivno.");

        var hasOverlap = await _appointmentRepository.HasOverlappingAppointmentAsync(
            command.Request.StaffId,
            command.Request.ScheduledAt,
            60,
            cancellationToken: cancellationToken);

        if (hasOverlap)
            throw new ConflictException("Odabrani termin se preklapa sa postojećim terminom za ovo osoblje.");

        var appointment = new Appointment
        {
            UserId = userId,
            StaffId = command.Request.StaffId,
            ScheduledAt = command.Request.ScheduledAt,
            DurationMinutes = 60,
            Notes = command.Request.Notes
        };

        await _appointmentRepository.AddAsync(appointment, cancellationToken);
        await _appointmentRepository.SaveChangesAsync(cancellationToken);

        var user = await _userRepository.GetByIdAsync(userId, cancellationToken);
        appointment.User = user!;
        appointment.Staff = staff;

        return appointment.ToResponse();
    }
}
