using FluentValidation;

namespace GroundZero.Application.Features.Reports.Queries;

public class GetProductReportQueryValidator : AbstractValidator<GetProductReportQuery>
{
    public GetProductReportQueryValidator()
    {
        RuleFor(x => x.Format)
            .IsInEnum().WithMessage("Nevažeći format izvještaja.");

        RuleFor(x => x.LowStockThreshold)
            .GreaterThanOrEqualTo(0).WithMessage("Prag niskog stanja mora biti 0 ili veći.");

        RuleFor(x => x.To)
            .GreaterThan(x => x.From)
            .When(x => x.From.HasValue && x.To.HasValue)
            .WithMessage("Datum 'do' mora biti nakon datuma 'od'.");
    }
}
