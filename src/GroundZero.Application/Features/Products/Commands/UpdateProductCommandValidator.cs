using FluentValidation;

namespace GroundZero.Application.Features.Products.Commands;

public class UpdateProductCommandValidator : AbstractValidator<UpdateProductCommand>
{
    public UpdateProductCommandValidator()
    {
        RuleFor(x => x.Request.Name)
            .NotEmpty().WithMessage("Naziv proizvoda je obavezan.")
            .MaximumLength(200).WithMessage("Naziv proizvoda ne smije biti duži od 200 karaktera.");

        RuleFor(x => x.Request.Description)
            .MaximumLength(2000).WithMessage("Opis proizvoda ne smije biti duži od 2000 karaktera.");

        RuleFor(x => x.Request.Price)
            .GreaterThan(0).WithMessage("Cijena mora biti veća od 0.");

        RuleFor(x => x.Request.StockQuantity)
            .GreaterThanOrEqualTo(0).WithMessage("Količina na stanju ne može biti negativna.");

        RuleFor(x => x.Request.CategoryId)
            .GreaterThan(0).WithMessage("Kategorija je obavezna.");
    }
}
