using FluentValidation;
using GroundZero.Domain.Enums;

namespace GroundZero.Application.Features.Orders.Commands;

public class UpdateOrderStatusCommandValidator : AbstractValidator<UpdateOrderStatusCommand>
{
    public UpdateOrderStatusCommandValidator()
    {
        RuleFor(x => x.Id)
            .GreaterThan(0).WithMessage("ID narudžbe mora biti veći od 0.");

        RuleFor(x => x.Request.Status)
            .IsInEnum().WithMessage("Nevažeći status narudžbe.");
    }
}
