using GroundZero.Application.Exceptions;
using GroundZero.Application.Features.GymVisits.DTOs;
using GroundZero.Application.IRepositories;
using GroundZero.Messaging;
using GroundZero.Messaging.Events;
using MediatR;

namespace GroundZero.Application.Features.GymVisits.Commands;

public class CheckOutCommandHandler : IRequestHandler<CheckOutCommand, GymVisitResponse>
{
    private readonly IGymVisitRepository _gymVisitRepository;
    private readonly IUserRepository _userRepository;
    private readonly ILevelRepository _levelRepository;
    private readonly IMessagePublisher _messagePublisher;

    public CheckOutCommandHandler(
        IGymVisitRepository gymVisitRepository,
        IUserRepository userRepository,
        ILevelRepository levelRepository,
        IMessagePublisher messagePublisher)
    {
        _gymVisitRepository = gymVisitRepository;
        _userRepository = userRepository;
        _levelRepository = levelRepository;
        _messagePublisher = messagePublisher;
    }

    public async Task<GymVisitResponse> Handle(CheckOutCommand command, CancellationToken cancellationToken)
    {
        var user = await _userRepository.GetByIdAsync(command.Request.UserId, cancellationToken)
            ?? throw new NotFoundException("Korisnik", command.Request.UserId);

        var activeVisit = await _gymVisitRepository.GetActiveVisitByUserIdAsync(command.Request.UserId, cancellationToken)
            ?? throw new NotFoundException("Korisnik nema aktivnu posjetu u teretani.");

        activeVisit.CheckOutAt = DateTime.UtcNow;
        var duration = (int)(activeVisit.CheckOutAt.Value - activeVisit.CheckInAt).TotalMinutes;
        activeVisit.DurationMinutes = duration;

        var xpEarned = duration / 10;

        user.TotalGymMinutes += duration;
        user.XP += xpEarned;

        var previousLevel = user.Level;
        var newLevel = await _levelRepository.GetLevelByXpAsync(user.XP, cancellationToken);
        if (newLevel != null && newLevel.Id > user.Level)
            user.Level = newLevel.Id;

        _gymVisitRepository.Update(activeVisit);
        _userRepository.Update(user);
        await _gymVisitRepository.SaveChangesAsync(cancellationToken);

        if (user.Level > previousLevel)
        {
            await _messagePublisher.PublishAsync(QueueNames.UserLevelUp, new UserLevelUpEvent
            {
                Email = user.Email,
                UserName = $"{user.FirstName} {user.LastName}",
                NewLevel = user.Level
            }, cancellationToken);
        }

        activeVisit.User = user;
        return activeVisit.ToResponse(xpEarned);
    }
}
