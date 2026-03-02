using FluentValidation;

namespace GroundZero.Application.Features.Staff.Commands;

public class CreateStaffCommandValidator : AbstractValidator<CreateStaffCommand>
{
    public CreateStaffCommandValidator()
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

        RuleFor(x => x.Request.Phone)
            .MaximumLength(30).WithMessage("Telefon ne smije biti duži od 30 karaktera.");

        RuleFor(x => x.Request.Bio)
            .MaximumLength(2000).WithMessage("Biografija ne smije biti duža od 2000 karaktera.");

        RuleFor(x => x.Request.StaffType)
            .NotEmpty().WithMessage("Tip osoblja je obavezan.")
            .Must(x => x == "Trainer" || x == "Nutritionist")
            .WithMessage("Tip osoblja mora biti 'Trainer' ili 'Nutritionist'.");
    }
}
