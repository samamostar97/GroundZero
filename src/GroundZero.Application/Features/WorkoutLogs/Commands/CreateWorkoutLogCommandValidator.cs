using FluentValidation;

namespace GroundZero.Application.Features.WorkoutLogs.Commands;

public class CreateWorkoutLogCommandValidator : AbstractValidator<CreateWorkoutLogCommand>
{
    public CreateWorkoutLogCommandValidator()
    {
        RuleFor(x => x.Request.WorkoutDayId)
            .GreaterThan(0).WithMessage("ID trening dana mora biti veći od 0.");

        RuleFor(x => x.Request.StartedAt)
            .NotEmpty().WithMessage("Vrijeme početka treninga je obavezno.");

        RuleFor(x => x.Request.CompletedAt)
            .GreaterThan(x => x.Request.StartedAt)
            .When(x => x.Request.CompletedAt.HasValue)
            .WithMessage("Vrijeme završetka mora biti nakon vremena početka.");

        RuleFor(x => x.Request.Notes)
            .MaximumLength(1000).WithMessage("Bilješke ne mogu biti duže od 1000 karaktera.");
    }
}
