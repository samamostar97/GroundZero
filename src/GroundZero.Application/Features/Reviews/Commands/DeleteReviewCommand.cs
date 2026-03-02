using FluentValidation;
using GroundZero.Application.Exceptions;
using GroundZero.Application.IRepositories;
using GroundZero.Application.IServices;
using MediatR;

namespace GroundZero.Application.Features.Reviews.Commands;

public class DeleteReviewCommand : IRequest<Unit>
{
    public int Id { get; set; }
}

public class DeleteReviewCommandValidator : AbstractValidator<DeleteReviewCommand>
{
    public DeleteReviewCommandValidator()
    {
        RuleFor(x => x.Id)
            .GreaterThan(0).WithMessage("ID recenzije mora biti veći od 0.");
    }
}

public class DeleteReviewCommandHandler : IRequestHandler<DeleteReviewCommand, Unit>
{
    private readonly IReviewRepository _reviewRepository;
    private readonly ICurrentUserService _currentUserService;

    public DeleteReviewCommandHandler(
        IReviewRepository reviewRepository,
        ICurrentUserService currentUserService)
    {
        _reviewRepository = reviewRepository;
        _currentUserService = currentUserService;
    }

    public async Task<Unit> Handle(DeleteReviewCommand command, CancellationToken cancellationToken)
    {
        var review = await _reviewRepository.GetByIdAsync(command.Id, cancellationToken)
            ?? throw new NotFoundException("Recenzija", command.Id);

        if (review.UserId != _currentUserService.UserId)
            throw new ForbiddenException();

        _reviewRepository.SoftDelete(review);
        await _reviewRepository.SaveChangesAsync(cancellationToken);

        return Unit.Value;
    }
}
