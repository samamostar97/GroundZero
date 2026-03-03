using FluentValidation;

namespace GroundZero.Application.Features.Memberships.Commands;

public class CreateMembershipPlanCommandValidator : AbstractValidator<CreateMembershipPlanCommand>
{
    public CreateMembershipPlanCommandValidator()
    {
        RuleFor(x => x.Request.Name)
            .NotEmpty().WithMessage("Naziv plana je obavezan.")
            .MaximumLength(100).WithMessage("Naziv plana ne smije biti duži od 100 karaktera.");

        RuleFor(x => x.Request.Description)
            .MaximumLength(500).WithMessage("Opis plana ne smije biti duži od 500 karaktera.");

        RuleFor(x => x.Request.Price)
            .GreaterThan(0).WithMessage("Cijena mora biti veća od 0.");

        RuleFor(x => x.Request.DurationDays)
            .GreaterThan(0).WithMessage("Trajanje mora biti najmanje 1 dan.");
    }
}
