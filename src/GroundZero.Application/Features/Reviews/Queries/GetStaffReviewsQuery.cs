using GroundZero.Application.Features.Reviews.DTOs;
using GroundZero.Application.IRepositories;
using MediatR;

namespace GroundZero.Application.Features.Reviews.Queries;

public class GetStaffReviewsQuery : IRequest<ReviewsWithRatingResponse>
{
    public int StaffId { get; set; }
    public int PageNumber { get; set; } = 1;
    public int PageSize { get; set; } = 10;
}

public class GetStaffReviewsQueryHandler : IRequestHandler<GetStaffReviewsQuery, ReviewsWithRatingResponse>
{
    private readonly IReviewRepository _reviewRepository;

    public GetStaffReviewsQueryHandler(IReviewRepository reviewRepository)
    {
        _reviewRepository = reviewRepository;
    }

    public async Task<ReviewsWithRatingResponse> Handle(GetStaffReviewsQuery query, CancellationToken cancellationToken)
    {
        var result = await _reviewRepository.GetStaffReviewsPagedAsync(
            query.StaffId, query.PageNumber, query.PageSize, cancellationToken);

        var averageRating = await _reviewRepository.GetAverageRatingForStaffAsync(
            query.StaffId, cancellationToken);

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
