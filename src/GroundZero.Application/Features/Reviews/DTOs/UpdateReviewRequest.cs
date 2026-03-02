namespace GroundZero.Application.Features.Reviews.DTOs;

public class UpdateReviewRequest
{
    public int Rating { get; set; }
    public string? Comment { get; set; }
}
