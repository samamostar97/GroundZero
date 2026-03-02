using FluentValidation;

namespace GroundZero.Application.Features.Reports.Queries;

public class GetGamificationReportQueryValidator : AbstractValidator<GetGamificationReportQuery>
{
    public GetGamificationReportQueryValidator()
    {
        RuleFor(x => x.Format)
            .IsInEnum().WithMessage("Nevažeći format izvještaja.");

        RuleFor(x => x.To)
            .GreaterThan(x => x.From)
            .When(x => x.From.HasValue && x.To.HasValue)
            .WithMessage("Datum 'do' mora biti nakon datuma 'od'.");
    }
}
