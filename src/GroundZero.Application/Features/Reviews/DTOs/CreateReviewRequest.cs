using GroundZero.Domain.Enums;

namespace GroundZero.Application.Features.Reviews.DTOs;

public class CreateReviewRequest
{
    public int Rating { get; set; }
    public string? Comment { get; set; }
    public ReviewType ReviewType { get; set; }
    public int? ProductId { get; set; }
    public int? AppointmentId { get; set; }
}
