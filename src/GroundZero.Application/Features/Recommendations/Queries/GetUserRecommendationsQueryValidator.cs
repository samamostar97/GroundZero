using FluentValidation;

namespace GroundZero.Application.Features.Recommendations.Queries;

public class GetUserRecommendationsQueryValidator : AbstractValidator<GetUserRecommendationsQuery>
{
    public GetUserRecommendationsQueryValidator()
    {
        RuleFor(x => x.Limit)
            .InclusiveBetween(1, 50).WithMessage("Limit mora biti između 1 i 50.");
    }
}
