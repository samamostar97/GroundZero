using GroundZero.Application.Exceptions;
using GroundZero.Application.Features.Staff.DTOs;
using GroundZero.Application.IRepositories;
using MediatR;

namespace GroundZero.Application.Features.Staff.Queries;

public class GetStaffAvailableSlotsQueryHandler : IRequestHandler<GetStaffAvailableSlotsQuery, List<TimeSlotResponse>>
{
    private readonly IStaffRepository _staffRepository;
    private readonly IAppointmentRepository _appointmentRepository;

    private static readonly TimeSpan WorkdayStart = new(8, 0, 0);
    private static readonly TimeSpan WorkdayEnd = new(17, 0, 0);
    private static readonly int SlotIntervalMinutes = 60;

    public GetStaffAvailableSlotsQueryHandler(
        IStaffRepository staffRepository,
        IAppointmentRepository appointmentRepository)
    {
        _staffRepository = staffRepository;
        _appointmentRepository = appointmentRepository;
    }

    public async Task<List<TimeSlotResponse>> Handle(
        GetStaffAvailableSlotsQuery query, CancellationToken cancellationToken)
    {
        var staff = await _staffRepository.GetByIdAsync(query.StaffId, cancellationToken)
            ?? throw new NotFoundException("Osoblje", query.StaffId);

        var appointments = await _appointmentRepository
            .GetStaffAppointmentsForDateAsync(query.StaffId, query.Date, cancellationToken);

        var slots = new List<TimeSlotResponse>();
        var current = WorkdayStart;

        while (current < WorkdayEnd)
        {
            var slotStart = query.Date.Date.Add(current);
            var slotEnd = slotStart.AddMinutes(SlotIntervalMinutes);

            var isAvailable = !appointments.Any(a =>
                a.ScheduledAt < slotEnd &&
                slotStart < a.ScheduledAt.AddMinutes(a.DurationMinutes));

            slots.Add(new TimeSlotResponse
            {
                Time = $"{current.Hours:D2}:{current.Minutes:D2}",
                IsAvailable = isAvailable,
            });

            current = current.Add(TimeSpan.FromMinutes(SlotIntervalMinutes));
        }

        return slots;
    }
}
