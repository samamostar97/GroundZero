using FluentValidation;

namespace GroundZero.Application.Features.GymVisits.Commands;

public class CheckOutCommandValidator : AbstractValidator<CheckOutCommand>
{
    public CheckOutCommandValidator()
    {
        RuleFor(x => x.Request.UserId)
            .GreaterThan(0).WithMessage("Korisnik ID je obavezan.");
    }
}
