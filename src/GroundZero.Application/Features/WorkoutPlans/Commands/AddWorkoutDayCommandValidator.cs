using FluentValidation;

namespace GroundZero.Application.Features.WorkoutPlans.Commands;

public class AddWorkoutDayCommandValidator : AbstractValidator<AddWorkoutDayCommand>
{
    public AddWorkoutDayCommandValidator()
    {
        RuleFor(x => x.WorkoutPlanId)
            .GreaterThan(0).WithMessage("ID plana mora biti veći od 0.");

        RuleFor(x => x.Request.DayOfWeek)
            .IsInEnum().WithMessage("Nevažeći dan u sedmici.");

        RuleFor(x => x.Request.Name)
            .NotEmpty().WithMessage("Naziv dana je obavezan.")
            .MaximumLength(200).WithMessage("Naziv dana ne može biti duži od 200 karaktera.");
    }
}
