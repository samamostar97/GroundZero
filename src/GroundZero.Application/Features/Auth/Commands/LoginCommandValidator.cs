using FluentValidation;

namespace GroundZero.Application.Features.Auth.Commands;

public class LoginCommandValidator : AbstractValidator<LoginCommand>
{
    public LoginCommandValidator()
    {
        RuleFor(x => x.Request.Email)
            .NotEmpty().WithMessage("Email je obavezan.");

        RuleFor(x => x.Request.Password)
            .NotEmpty().WithMessage("Lozinka je obavezna.");
    }
}
