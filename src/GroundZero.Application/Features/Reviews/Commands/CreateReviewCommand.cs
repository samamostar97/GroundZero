using FluentValidation;
using GroundZero.Application.Common;
using GroundZero.Application.Exceptions;
using GroundZero.Application.Features.Reviews.DTOs;
using GroundZero.Application.IRepositories;
using GroundZero.Application.IServices;
using GroundZero.Domain.Entities;
using GroundZero.Domain.Enums;
using MediatR;

namespace GroundZero.Application.Features.Reviews.Commands;

[AuthorizeRole("User")]
public class CreateReviewCommand : IRequest<ReviewResponse>
{
    public CreateReviewRequest Request { get; set; } = null!;
}

public class CreateReviewCommandValidator : AbstractValidator<CreateReviewCommand>
{
    public CreateReviewCommandValidator()
    {
        RuleFor(x => x.Request.Rating)
            .InclusiveBetween(1, 5).WithMessage("Ocjena mora biti između 1 i 5.");

        RuleFor(x => x.Request.Comment)
            .MaximumLength(2000).WithMessage("Komentar ne može biti duži od 2000 karaktera.");

        RuleFor(x => x.Request.ReviewType)
            .IsInEnum().WithMessage("Nevažeći tip recenzije.");

        RuleFor(x => x.Request.ProductId)
            .NotNull().When(x => x.Request.ReviewType == ReviewType.Product)
            .WithMessage("ProductId je obavezan za recenziju proizvoda.")
            .GreaterThan(0).When(x => x.Request.ReviewType == ReviewType.Product)
            .WithMessage("ProductId mora biti veći od 0.");

        RuleFor(x => x.Request.AppointmentId)
            .NotNull().When(x => x.Request.ReviewType == ReviewType.Appointment)
            .WithMessage("AppointmentId je obavezan za recenziju termina.")
            .GreaterThan(0).When(x => x.Request.ReviewType == ReviewType.Appointment)
            .WithMessage("AppointmentId mora biti veći od 0.");
    }
}

public class CreateReviewCommandHandler : IRequestHandler<CreateReviewCommand, ReviewResponse>
{
    private readonly IReviewRepository _reviewRepository;
    private readonly IProductRepository _productRepository;
    private readonly IAppointmentRepository _appointmentRepository;
    private readonly ICurrentUserService _currentUserService;
    private readonly IUserRepository _userRepository;

    public CreateReviewCommandHandler(
        IReviewRepository reviewRepository,
        IProductRepository productRepository,
        IAppointmentRepository appointmentRepository,
        ICurrentUserService currentUserService,
        IUserRepository userRepository)
    {
        _reviewRepository = reviewRepository;
        _productRepository = productRepository;
        _appointmentRepository = appointmentRepository;
        _currentUserService = currentUserService;
        _userRepository = userRepository;
    }

    public async Task<ReviewResponse> Handle(CreateReviewCommand command, CancellationToken cancellationToken)
    {
        var userId = _currentUserService.UserId
            ?? throw new UnauthorizedAccessException("Morate biti prijavljeni.");

        var request = command.Request;
        Product? product = null;
        Appointment? appointment = null;

        if (request.ReviewType == ReviewType.Product)
        {
            product = await _productRepository.GetByIdAsync(request.ProductId!.Value, cancellationToken)
                ?? throw new NotFoundException("Proizvod", request.ProductId.Value);

            var alreadyReviewed = await _reviewRepository.HasUserReviewedProductAsync(userId, request.ProductId.Value, cancellationToken);
            if (alreadyReviewed)
                throw new ConflictException("Već ste ostavili recenziju za ovaj proizvod.");
        }
        else
        {
            appointment = await _appointmentRepository.GetByIdWithDetailsAsync(request.AppointmentId!.Value, cancellationToken)
                ?? throw new NotFoundException("Termin", request.AppointmentId.Value);

            if (appointment.UserId != userId)
                throw new ForbiddenException("Ne možete ostaviti recenziju za tuđi termin.");

            if (appointment.Status != AppointmentStatus.Completed)
                throw new InvalidOperationException("Recenziju možete ostaviti samo za završene termine.");

            var alreadyReviewed = await _reviewRepository.HasUserReviewedAppointmentAsync(userId, request.AppointmentId.Value, cancellationToken);
            if (alreadyReviewed)
                throw new ConflictException("Već ste ostavili recenziju za ovaj termin.");
        }

        var review = new Review
        {
            UserId = userId,
            Rating = request.Rating,
            Comment = request.Comment,
            ReviewType = request.ReviewType,
            ProductId = request.ReviewType == ReviewType.Product ? request.ProductId : null,
            AppointmentId = request.ReviewType == ReviewType.Appointment ? request.AppointmentId : null
        };

        await _reviewRepository.AddAsync(review, cancellationToken);
        await _reviewRepository.SaveChangesAsync(cancellationToken);

        var user = await _userRepository.GetByIdAsync(userId, cancellationToken);
        review.User = user!;
        review.Product = product;
        review.Appointment = appointment;

        return review.ToResponse();
    }
}
