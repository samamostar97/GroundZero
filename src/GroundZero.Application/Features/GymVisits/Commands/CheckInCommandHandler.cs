using GroundZero.Application.Exceptions;
using GroundZero.Application.Features.GymVisits.DTOs;
using GroundZero.Application.IRepositories;
using GroundZero.Domain.Entities;
using MediatR;

namespace GroundZero.Application.Features.GymVisits.Commands;

public class CheckInCommandHandler : IRequestHandler<CheckInCommand, GymVisitResponse>
{
    private readonly IGymVisitRepository _gymVisitRepository;
    private readonly IUserRepository _userRepository;

    public CheckInCommandHandler(IGymVisitRepository gymVisitRepository, IUserRepository userRepository)
    {
        _gymVisitRepository = gymVisitRepository;
        _userRepository = userRepository;
    }

    public async Task<GymVisitResponse> Handle(CheckInCommand command, CancellationToken cancellationToken)
    {
        var user = await _userRepository.GetByIdAsync(command.Request.UserId, cancellationToken)
            ?? throw new NotFoundException("Korisnik", command.Request.UserId);

        var activeVisit = await _gymVisitRepository.GetActiveVisitByUserIdAsync(command.Request.UserId, cancellationToken);
        if (activeVisit != null)
            throw new ConflictException("Korisnik već ima aktivnu posjetu u teretani.");

        var gymVisit = new GymVisit
        {
            UserId = command.Request.UserId,
            CheckInAt = DateTime.UtcNow
        };

        await _gymVisitRepository.AddAsync(gymVisit, cancellationToken);
        await _gymVisitRepository.SaveChangesAsync(cancellationToken);

        gymVisit.User = user;
        return gymVisit.ToResponse();
    }
}
