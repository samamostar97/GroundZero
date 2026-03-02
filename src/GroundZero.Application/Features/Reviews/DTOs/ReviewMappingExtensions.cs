using GroundZero.Domain.Entities;

namespace GroundZero.Application.Features.Reviews.DTOs;

public static class ReviewMappingExtensions
{
    public static ReviewResponse ToResponse(this Review review)
    {
        return new ReviewResponse
        {
            Id = review.Id,
            UserId = review.UserId,
            UserFullName = $"{review.User.FirstName} {review.User.LastName}",
            Rating = review.Rating,
            Comment = review.Comment,
            ReviewType = review.ReviewType.ToString(),
            ProductId = review.ProductId,
            ProductName = review.Product?.Name,
            AppointmentId = review.AppointmentId,
            StaffFullName = review.Appointment?.Staff != null
                ? $"{review.Appointment.Staff.FirstName} {review.Appointment.Staff.LastName}"
                : null,
            StaffType = review.Appointment?.Staff?.StaffType.ToString(),
            CreatedAt = review.CreatedAt
        };
    }
}
