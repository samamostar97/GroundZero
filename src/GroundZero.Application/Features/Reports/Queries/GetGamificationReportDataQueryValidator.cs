using FluentValidation;

namespace GroundZero.Application.Features.Reports.Queries;

public class GetGamificationReportDataQueryValidator : AbstractValidator<GetGamificationReportDataQuery>
{
    public GetGamificationReportDataQueryValidator()
    {
        RuleFor(x => x.To)
            .GreaterThan(x => x.From)
            .When(x => x.From.HasValue && x.To.HasValue)
            .WithMessage("Datum 'do' mora biti nakon datuma 'od'.");
    }
}
