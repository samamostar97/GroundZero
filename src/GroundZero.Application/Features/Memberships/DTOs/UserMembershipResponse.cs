namespace GroundZero.Application.Features.Memberships.DTOs;

public class UserMembershipResponse
{
    public int Id { get; set; }
    public int UserId { get; set; }
    public string UserFullName { get; set; } = string.Empty;
    public string UserEmail { get; set; } = string.Empty;
    public string PlanName { get; set; } = string.Empty;
    public decimal PlanPrice { get; set; }
    public int DurationDays { get; set; }
    public DateTime StartDate { get; set; }
    public DateTime EndDate { get; set; }
    public string Status { get; set; } = string.Empty;
    public DateTime CreatedAt { get; set; }
}
