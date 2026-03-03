using FluentValidation;

namespace GroundZero.Application.Features.Memberships.Commands;

public class DeleteMembershipPlanCommandValidator : AbstractValidator<DeleteMembershipPlanCommand>
{
    public DeleteMembershipPlanCommandValidator()
    {
        RuleFor(x => x.Id)
            .GreaterThan(0).WithMessage("ID plana je obavezan.");
    }
}
