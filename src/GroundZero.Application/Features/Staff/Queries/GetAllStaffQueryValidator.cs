using FluentValidation;

namespace GroundZero.Application.Features.Staff.Queries;

public class GetAllStaffQueryValidator : AbstractValidator<GetAllStaffQuery>
{
    public GetAllStaffQueryValidator()
    {
        RuleFor(x => x.PageNumber)
            .GreaterThanOrEqualTo(1).WithMessage("Broj stranice mora biti najmanje 1.");

        RuleFor(x => x.PageSize)
            .InclusiveBetween(1, 100).WithMessage("Veličina stranice mora biti između 1 i 100.");
    }
}
