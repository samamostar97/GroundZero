using FluentValidation;

namespace GroundZero.Application.Features.Orders.Commands;

public class CreateOrderCommandValidator : AbstractValidator<CreateOrderCommand>
{
    public CreateOrderCommandValidator()
    {
        RuleFor(x => x.Request.Items)
            .NotEmpty().WithMessage("Narudžba mora sadržavati barem jedan proizvod.");

        RuleForEach(x => x.Request.Items).ChildRules(item =>
        {
            item.RuleFor(i => i.ProductId)
                .GreaterThan(0).WithMessage("ID proizvoda mora biti veći od 0.");

            item.RuleFor(i => i.Quantity)
                .GreaterThan(0).WithMessage("Količina mora biti veća od 0.");
        });
    }
}
