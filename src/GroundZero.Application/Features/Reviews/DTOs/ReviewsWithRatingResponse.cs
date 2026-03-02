using GroundZero.Application.Common;

namespace GroundZero.Application.Features.Reviews.DTOs;

public class ReviewsWithRatingResponse
{
    public double? AverageRating { get; set; }
    public PagedResult<ReviewResponse> Reviews { get; set; } = null!;
}
