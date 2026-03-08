using FluentValidation;

namespace GroundZero.Application.Features.Reports.Queries;

public class GetRevenueReportDataQueryValidator : AbstractValidator<GetRevenueReportDataQuery>
{
    public GetRevenueReportDataQueryValidator()
    {
        RuleFor(x => x.To)
            .GreaterThan(x => x.From)
            .When(x => x.From.HasValue && x.To.HasValue)
            .WithMessage("Datum 'do' mora biti nakon datuma 'od'.");
    }
}
