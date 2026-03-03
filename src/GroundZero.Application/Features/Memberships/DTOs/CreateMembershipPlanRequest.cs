namespace GroundZero.Application.Features.Memberships.DTOs;

public class CreateMembershipPlanRequest
{
    public string Name { get; set; } = string.Empty;
    public string? Description { get; set; }
    public decimal Price { get; set; }
    public int DurationDays { get; set; }
}
