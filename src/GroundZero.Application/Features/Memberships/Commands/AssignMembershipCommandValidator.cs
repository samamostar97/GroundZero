using FluentValidation;

namespace GroundZero.Application.Features.Memberships.Commands;

public class AssignMembershipCommandValidator : AbstractValidator<AssignMembershipCommand>
{
    public AssignMembershipCommandValidator()
    {
        RuleFor(x => x.Request.UserId)
            .GreaterThan(0).WithMessage("Korisnik je obavezan.");

        RuleFor(x => x.Request.MembershipPlanId)
            .GreaterThan(0).WithMessage("Plan članarine je obavezan.");

        RuleFor(x => x.Request.StartDate)
            .NotEmpty().WithMessage("Datum početka je obavezan.");
    }
}
