namespace GroundZero.Application.Features.Users.DTOs;

public class UserResponse
{
    public int Id { get; set; }
    public string FirstName { get; set; } = string.Empty;
    public string LastName { get; set; } = string.Empty;
    public string Email { get; set; } = string.Empty;
    public string? ProfileImageUrl { get; set; }
    public string Role { get; set; } = string.Empty;
    public int Level { get; set; }
    public int XP { get; set; }
    public int TotalGymMinutes { get; set; }
    public DateTime CreatedAt { get; set; }
}
