using GroundZero.Domain.Enums;

namespace GroundZero.Domain.Entities;

public class Staff : BaseEntity
{
    public string FirstName { get; set; } = string.Empty;
    public string LastName { get; set; } = string.Empty;
    public string Email { get; set; } = string.Empty;
    public string? Phone { get; set; }
    public string? Bio { get; set; }
    public string? ProfileImageUrl { get; set; }
    public StaffType StaffType { get; set; }
    public bool IsActive { get; set; } = true;
}
