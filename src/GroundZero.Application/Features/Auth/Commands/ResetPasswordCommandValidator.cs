using FluentValidation;

namespace GroundZero.Application.Features.Auth.Commands;

public class ResetPasswordCommandValidator : AbstractValidator<ResetPasswordCommand>
{
    public ResetPasswordCommandValidator()
    {
        RuleFor(x => x.Request.Email)
            .NotEmpty().WithMessage("Email je obavezan.")
            .EmailAddress().WithMessage("Email format nije validan.");

        RuleFor(x => x.Request.Code)
            .NotEmpty().WithMessage("Kod je obavezan.");

        RuleFor(x => x.Request.NewPassword)
            .NotEmpty().WithMessage("Nova lozinka je obavezna.")
            .MinimumLength(6).WithMessage("Nova lozinka mora imati najmanje 6 karaktera.");
    }
}
