using GroundZero.Application.Features.Reviews.DTOs;
using GroundZero.Application.IRepositories;
using MediatR;

namespace GroundZero.Application.Features.Reviews.Queries;

public class GetProductReviewsQuery : IRequest<ReviewsWithRatingResponse>
{
    public int ProductId { get; set; }
    public int PageNumber { get; set; } = 1;
    public int PageSize { get; set; } = 10;
}

public class GetProductReviewsQueryHandler : IRequestHandler<GetProductReviewsQuery, ReviewsWithRatingResponse>
{
    private readonly IReviewRepository _reviewRepository;

    public GetProductReviewsQueryHandler(IReviewRepository reviewRepository)
    {
        _reviewRepository = reviewRepository;
    }

    public async Task<ReviewsWithRatingResponse> Handle(GetProductReviewsQuery query, CancellationToken cancellationToken)
    {
        var result = await _reviewRepository.GetProductReviewsPagedAsync(
            query.ProductId, query.PageNumber, query.PageSize, cancellationToken);

        var averageRating = await _reviewRepository.GetAverageRatingForProductAsync(
            query.ProductId, cancellationToken);

        return new ReviewsWithRatingResponse
        {
            AverageRating = averageRating,
            Reviews = new Common.PagedResult<ReviewResponse>
            {
                Items = result.Items.Select(r => r.ToResponse()).ToList(),
                TotalCount = result.TotalCount,
                PageNumber = result.PageNumber,
                PageSize = result.PageSize
            }
        };
    }
}
