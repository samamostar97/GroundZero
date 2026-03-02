using FluentValidation;
using GroundZero.Application.Exceptions;
using GroundZero.Application.Features.Reviews.DTOs;
using GroundZero.Application.IRepositories;
using GroundZero.Application.IServices;
using MediatR;

namespace GroundZero.Application.Features.Reviews.Commands;

public class UpdateReviewCommand : IRequest<ReviewResponse>
{
    public int Id { get; set; }
    public UpdateReviewRequest Request { get; set; } = null!;
}

public class UpdateReviewCommandValidator : AbstractValidator<UpdateReviewCommand>
{
    public UpdateReviewCommandValidator()
    {
        RuleFor(x => x.Id)
            .GreaterThan(0).WithMessage("ID recenzije mora biti veći od 0.");

        RuleFor(x => x.Request.Rating)
            .InclusiveBetween(1, 5).WithMessage("Ocjena mora biti između 1 i 5.");

        RuleFor(x => x.Request.Comment)
            .MaximumLength(2000).WithMessage("Komentar ne može biti duži od 2000 karaktera.");
    }
}

public class UpdateReviewCommandHandler : IRequestHandler<UpdateReviewCommand, ReviewResponse>
{
    private readonly IReviewRepository _reviewRepository;
    private readonly ICurrentUserService _currentUserService;

    public UpdateReviewCommandHandler(
        IReviewRepository reviewRepository,
        ICurrentUserService currentUserService)
    {
        _reviewRepository = reviewRepository;
        _currentUserService = currentUserService;
    }

    public async Task<ReviewResponse> Handle(UpdateReviewCommand command, CancellationToken cancellationToken)
    {
        var review = await _reviewRepository.GetByIdWithDetailsAsync(command.Id, cancellationToken)
            ?? throw new NotFoundException("Recenzija", command.Id);

        if (review.UserId != _currentUserService.UserId)
            throw new ForbiddenException();

        review.Rating = command.Request.Rating;
        review.Comment = command.Request.Comment;

        _reviewRepository.Update(review);
        await _reviewRepository.SaveChangesAsync(cancellationToken);

        return review.ToResponse();
    }
}
