using FluentValidation;

namespace GroundZero.Application.Features.Users.Commands;

public class UpdateProfileCommandValidator : AbstractValidator<UpdateProfileCommand>
{
    public UpdateProfileCommandValidator()
    {
        RuleFor(x => x.Request.FirstName)
            .NotEmpty().WithMessage("Ime je obavezno.")
            .MaximumLength(100).WithMessage("Ime ne smije biti duže od 100 karaktera.");

        RuleFor(x => x.Request.LastName)
            .NotEmpty().WithMessage("Prezime je obavezno.")
            .MaximumLength(100).WithMessage("Prezime ne smije biti duže od 100 karaktera.");
    }
}
