using FluentValidation;

namespace GroundZero.Application.Features.GymVisits.Commands;

public class CheckInCommandValidator : AbstractValidator<CheckInCommand>
{
    public CheckInCommandValidator()
    {
        RuleFor(x => x.Request.UserId)
            .GreaterThan(0).WithMessage("Korisnik ID je obavezan.");
    }
}
