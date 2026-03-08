using FluentValidation;

namespace GroundZero.Application.Features.Users.Commands;

public class ChangePasswordCommandValidator : AbstractValidator<ChangePasswordCommand>
{
    public ChangePasswordCommandValidator()
    {
        RuleFor(x => x.Request.CurrentPassword)
            .NotEmpty().WithMessage("Trenutna lozinka je obavezna.");

        RuleFor(x => x.Request.NewPassword)
            .NotEmpty().WithMessage("Nova lozinka je obavezna.")
            .MinimumLength(6).WithMessage("Nova lozinka mora imati najmanje 6 karaktera.");
    }
}
