namespace GroundZero.Application.Features.Staff.DTOs;

public class CreateStaffRequest
{
    public string FirstName { get; set; } = string.Empty;
    public string LastName { get; set; } = string.Empty;
    public string Email { get; set; } = string.Empty;
    public string? Phone { get; set; }
    public string? Bio { get; set; }
    public string StaffType { get; set; } = string.Empty;
}
