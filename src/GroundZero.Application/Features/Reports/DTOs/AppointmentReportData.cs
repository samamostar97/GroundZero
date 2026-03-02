namespace GroundZero.Application.Features.Reports.DTOs;

public class AppointmentReportData
{
    public DateTime From { get; set; }
    public DateTime To { get; set; }
    public int TotalAppointments { get; set; }
    public int CompletedAppointments { get; set; }
    public int CancelledAppointments { get; set; }
    public double CancellationRate { get; set; }
    public List<StaffBookingItem> StaffBookings { get; set; } = new();
    public List<PeakHourItem> PeakHours { get; set; } = new();
    public List<MonthlyAppointmentItem> MonthlyAppointments { get; set; } = new();
}

public class StaffBookingItem
{
    public string StaffName { get; set; } = string.Empty;
    public string StaffType { get; set; } = string.Empty;
    public int TotalBookings { get; set; }
    public int CompletedBookings { get; set; }
    public int CancelledBookings { get; set; }
}

public class PeakHourItem
{
    public int Hour { get; set; }
    public int AppointmentCount { get; set; }
}

public class MonthlyAppointmentItem
{
    public string Month { get; set; } = string.Empty;
    public int Year { get; set; }
    public int Count { get; set; }
    public int CancelledCount { get; set; }
}
