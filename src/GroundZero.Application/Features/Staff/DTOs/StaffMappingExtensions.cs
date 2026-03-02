namespace GroundZero.Application.Features.Staff.DTOs;

public static class StaffMappingExtensions
{
    public static StaffResponse ToResponse(this Domain.Entities.Staff staff)
    {
        return new StaffResponse
        {
            Id = staff.Id,
            FirstName = staff.FirstName,
            LastName = staff.LastName,
            Email = staff.Email,
            Phone = staff.Phone,
            Bio = staff.Bio,
            ProfileImageUrl = staff.ProfileImageUrl,
            StaffType = staff.StaffType.ToString(),
            IsActive = staff.IsActive,
            CreatedAt = staff.CreatedAt
        };
    }
}
