using FluentValidation;

namespace GroundZero.Application.Features.Auth.Commands;

public class RegisterCommandValidator : AbstractValidator<RegisterCommand>
{
    public RegisterCommandValidator()
    {
        RuleFor(x => x.Request.FirstName)
            .NotEmpty().WithMessage("Ime je obavezno.")
            .MaximumLength(100).WithMessage("Ime ne smije biti duže od 100 karaktera.");

        RuleFor(x => x.Request.LastName)
            .NotEmpty().WithMessage("Prezime je obavezno.")
            .MaximumLength(100).WithMessage("Prezime ne smije biti duže od 100 karaktera.");

        RuleFor(x => x.Request.Email)
            .NotEmpty().WithMessage("Email je obavezan.")
            .EmailAddress().WithMessage("Email format nije validan.")
            .MaximumLength(256).WithMessage("Email ne smije biti duži od 256 karaktera.");

        RuleFor(x => x.Request.Password)
            .NotEmpty().WithMessage("Lozinka je obavezna.")
            .MinimumLength(6).WithMessage("Lozinka mora imati najmanje 6 karaktera.");

        RuleFor(x => x.Request.ConfirmPassword)
            .Equal(x => x.Request.Password).WithMessage("Lozinke se ne podudaraju.");
    }
}
