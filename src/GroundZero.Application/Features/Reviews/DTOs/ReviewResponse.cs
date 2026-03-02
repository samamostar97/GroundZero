namespace GroundZero.Application.Features.Reviews.DTOs;

public class ReviewResponse
{
    public int Id { get; set; }
    public int UserId { get; set; }
    public string UserFullName { get; set; } = string.Empty;
    public int Rating { get; set; }
    public string? Comment { get; set; }
    public string ReviewType { get; set; } = string.Empty;
    public int? ProductId { get; set; }
    public string? ProductName { get; set; }
    public int? AppointmentId { get; set; }
    public string? StaffFullName { get; set; }
    public string? StaffType { get; set; }
    public DateTime CreatedAt { get; set; }
}
