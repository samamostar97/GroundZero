using GroundZero.Domain.Enums;

namespace GroundZero.Domain.Entities;

public class User : BaseEntity
{
    public string FirstName { get; set; } = string.Empty;
    public string LastName { get; set; } = string.Empty;
    public string Email { get; set; } = string.Empty;
    public string PasswordHash { get; set; } = string.Empty;
    public string? ProfileImageUrl { get; set; }
    public Role Role { get; set; }
    public int Level { get; set; } = 1;
    public int XP { get; set; }
    public int TotalGymMinutes { get; set; }
}
