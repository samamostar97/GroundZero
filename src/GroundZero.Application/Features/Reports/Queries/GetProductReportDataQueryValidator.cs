using FluentValidation;

namespace GroundZero.Application.Features.Reports.Queries;

public class GetProductReportDataQueryValidator : AbstractValidator<GetProductReportDataQuery>
{
    public GetProductReportDataQueryValidator()
    {
        RuleFor(x => x.LowStockThreshold)
            .GreaterThanOrEqualTo(0)
            .WithMessage("Prag niskog stanja mora biti pozitivan broj.");

        RuleFor(x => x.To)
            .GreaterThan(x => x.From)
            .When(x => x.From.HasValue && x.To.HasValue)
            .WithMessage("Datum 'do' mora biti nakon datuma 'od'.");
    }
}
