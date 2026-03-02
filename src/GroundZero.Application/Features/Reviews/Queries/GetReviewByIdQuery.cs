using GroundZero.Application.Exceptions;
using GroundZero.Application.Features.Reviews.DTOs;
using GroundZero.Application.IRepositories;
using MediatR;

namespace GroundZero.Application.Features.Reviews.Queries;

public class GetReviewByIdQuery : IRequest<ReviewResponse>
{
    public int Id { get; set; }
}

public class GetReviewByIdQueryHandler : IRequestHandler<GetReviewByIdQuery, ReviewResponse>
{
    private readonly IReviewRepository _reviewRepository;

    public GetReviewByIdQueryHandler(IReviewRepository reviewRepository)
    {
        _reviewRepository = reviewRepository;
    }

    public async Task<ReviewResponse> Handle(GetReviewByIdQuery query, CancellationToken cancellationToken)
    {
        var review = await _reviewRepository.GetByIdWithDetailsAsync(query.Id, cancellationToken)
            ?? throw new NotFoundException("Recenzija", query.Id);

        return review.ToResponse();
    }
}
