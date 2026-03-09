namespace GroundZero.Application.Features.Dashboard.DTOs;

public class DashboardResponse
{
    public int CurrentlyInGym { get; set; }
    public int PendingOrderCount { get; set; }
    public int PendingAppointmentCount { get; set; }
    public int NewUsersThisMonth { get; set; }
    public List<ActiveGymVisitItem> ActiveGymVisits { get; set; } = new();
    public List<PendingOrderItem> PendingOrders { get; set; } = new();
}

public class ActiveGymVisitItem
{
    public int Id { get; set; }
    public int UserId { get; set; }
    public string UserFullName { get; set; } = string.Empty;
    public DateTime CheckInAt { get; set; }
}

public class PendingOrderItem
{
    public int Id { get; set; }
    public int UserId { get; set; }
    public string UserFullName { get; set; } = string.Empty;
    public decimal TotalAmount { get; set; }
    public int ItemCount { get; set; }
    public DateTime CreatedAt { get; set; }
}
