using FluentValidation;

namespace GroundZero.Application.Features.Memberships.Commands;

public class CancelMembershipCommandValidator : AbstractValidator<CancelMembershipCommand>
{
    public CancelMembershipCommandValidator()
    {
        RuleFor(x => x.Id)
            .GreaterThan(0).WithMessage("ID članarine je obavezan.");
    }
}
