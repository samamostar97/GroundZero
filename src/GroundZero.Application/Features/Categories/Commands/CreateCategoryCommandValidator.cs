using FluentValidation;

namespace GroundZero.Application.Features.Categories.Commands;

public class CreateCategoryCommandValidator : AbstractValidator<CreateCategoryCommand>
{
    public CreateCategoryCommandValidator()
    {
        RuleFor(x => x.Request.Name)
            .NotEmpty().WithMessage("Naziv kategorije je obavezan.")
            .MaximumLength(100).WithMessage("Naziv kategorije ne smije biti duži od 100 karaktera.");

        RuleFor(x => x.Request.Description)
            .MaximumLength(500).WithMessage("Opis kategorije ne smije biti duži od 500 karaktera.");
    }
}
