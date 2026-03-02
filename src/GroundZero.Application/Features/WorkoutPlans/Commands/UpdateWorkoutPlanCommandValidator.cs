using FluentValidation;

namespace GroundZero.Application.Features.WorkoutPlans.Commands;

public class UpdateWorkoutPlanCommandValidator : AbstractValidator<UpdateWorkoutPlanCommand>
{
    public UpdateWorkoutPlanCommandValidator()
    {
        RuleFor(x => x.Id)
            .GreaterThan(0).WithMessage("ID plana mora biti veći od 0.");

        RuleFor(x => x.Request.Name)
            .NotEmpty().WithMessage("Naziv plana je obavezan.")
            .MaximumLength(200).WithMessage("Naziv plana ne može biti duži od 200 karaktera.");

        RuleFor(x => x.Request.Description)
            .MaximumLength(1000).WithMessage("Opis plana ne može biti duži od 1000 karaktera.");
    }
}
