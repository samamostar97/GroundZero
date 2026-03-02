using FluentValidation;

namespace GroundZero.Application.Features.WorkoutPlans.Commands;

public class UpdateWorkoutExerciseCommandValidator : AbstractValidator<UpdateWorkoutExerciseCommand>
{
    public UpdateWorkoutExerciseCommandValidator()
    {
        RuleFor(x => x.WorkoutPlanId)
            .GreaterThan(0).WithMessage("ID plana mora biti veći od 0.");

        RuleFor(x => x.DayId)
            .GreaterThan(0).WithMessage("ID dana mora biti veći od 0.");

        RuleFor(x => x.ExerciseId)
            .GreaterThan(0).WithMessage("ID vježbe mora biti veći od 0.");

        RuleFor(x => x.Request.Sets)
            .GreaterThan(0).WithMessage("Broj serija mora biti veći od 0.");

        RuleFor(x => x.Request.Reps)
            .GreaterThan(0).WithMessage("Broj ponavljanja mora biti veći od 0.");

        RuleFor(x => x.Request.Weight)
            .GreaterThanOrEqualTo(0).When(x => x.Request.Weight.HasValue)
            .WithMessage("Težina ne može biti negativna.");

        RuleFor(x => x.Request.RestSeconds)
            .GreaterThanOrEqualTo(0).When(x => x.Request.RestSeconds.HasValue)
            .WithMessage("Odmor ne može biti negativan.");

        RuleFor(x => x.Request.OrderIndex)
            .GreaterThanOrEqualTo(0).WithMessage("Redoslijed mora biti 0 ili veći.");
    }
}
