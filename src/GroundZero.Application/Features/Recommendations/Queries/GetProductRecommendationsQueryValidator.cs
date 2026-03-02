using FluentValidation;

namespace GroundZero.Application.Features.Recommendations.Queries;

public class GetProductRecommendationsQueryValidator : AbstractValidator<GetProductRecommendationsQuery>
{
    public GetProductRecommendationsQueryValidator()
    {
        RuleFor(x => x.ProductId)
            .GreaterThan(0).WithMessage("ID proizvoda mora biti veći od 0.");

        RuleFor(x => x.Limit)
            .InclusiveBetween(1, 50).WithMessage("Limit mora biti između 1 i 50.");
    }
}
