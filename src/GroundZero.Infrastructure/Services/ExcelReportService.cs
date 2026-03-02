using ClosedXML.Excel;
using GroundZero.Application.Features.Reports.DTOs;
using GroundZero.Application.IServices;

namespace GroundZero.Infrastructure.Services;

public class ExcelReportService : IExcelReportService
{
    public byte[] GenerateRevenueReport(RevenueReportData data)
    {
        using var workbook = new XLWorkbook();

        // Sheet 1: Pregled
        var summarySheet = workbook.Worksheets.Add("Pregled");
        summarySheet.Cell(1, 1).Value = "Izvještaj o prihodima";
        summarySheet.Cell(1, 1).Style.Font.Bold = true;
        summarySheet.Cell(1, 1).Style.Font.FontSize = 14;
        summarySheet.Cell(2, 1).Value = $"Period: {data.From:dd.MM.yyyy} - {data.To:dd.MM.yyyy}";

        summarySheet.Cell(4, 1).Value = "Ukupni prihod od narudžbi (KM)";
        summarySheet.Cell(4, 2).Value = data.TotalOrderRevenue;
        summarySheet.Cell(4, 2).Style.NumberFormat.Format = "#,##0.00";
        summarySheet.Cell(5, 1).Value = "Ukupan broj narudžbi";
        summarySheet.Cell(5, 2).Value = data.TotalOrders;
        summarySheet.Cell(6, 1).Value = "Ukupan broj termina";
        summarySheet.Cell(6, 2).Value = data.TotalAppointments;
        summarySheet.Columns().AdjustToContents();

        // Sheet 2: Mjesečni pregled
        var monthlySheet = workbook.Worksheets.Add("Mjesečni pregled");
        var headers = new[] { "Mjesec", "Godina", "Prihod (KM)", "Broj narudžbi" };
        AddHeaders(monthlySheet, headers);

        for (var i = 0; i < data.MonthlyRevenue.Count; i++)
        {
            var item = data.MonthlyRevenue[i];
            var row = i + 2;
            monthlySheet.Cell(row, 1).Value = item.Month;
            monthlySheet.Cell(row, 2).Value = item.Year;
            monthlySheet.Cell(row, 3).Value = item.Revenue;
            monthlySheet.Cell(row, 3).Style.NumberFormat.Format = "#,##0.00";
            monthlySheet.Cell(row, 4).Value = item.OrderCount;
        }
        ApplyTableFormatting(monthlySheet, headers.Length, data.MonthlyRevenue.Count);

        // Sheet 3: Kategorije
        var categorySheet = workbook.Worksheets.Add("Kategorije");
        var catHeaders = new[] { "Kategorija", "Prihod (KM)", "Prodano komada" };
        AddHeaders(categorySheet, catHeaders);

        for (var i = 0; i < data.CategoryRevenue.Count; i++)
        {
            var item = data.CategoryRevenue[i];
            var row = i + 2;
            categorySheet.Cell(row, 1).Value = item.CategoryName;
            categorySheet.Cell(row, 2).Value = item.Revenue;
            categorySheet.Cell(row, 2).Style.NumberFormat.Format = "#,##0.00";
            categorySheet.Cell(row, 3).Value = item.ItemsSold;
        }
        ApplyTableFormatting(categorySheet, catHeaders.Length, data.CategoryRevenue.Count);

        return SaveWorkbook(workbook);
    }

    public byte[] GenerateProductReport(ProductReportData data)
    {
        using var workbook = new XLWorkbook();

        // Sheet 1: Najtraženiji
        var bestSheet = workbook.Worksheets.Add("Najtraženiji");
        bestSheet.Cell(1, 1).Value = $"Izvještaj o proizvodima ({data.From:dd.MM.yyyy} - {data.To:dd.MM.yyyy})";
        bestSheet.Cell(1, 1).Style.Font.Bold = true;
        bestSheet.Cell(2, 1).Value = $"Ukupno proizvoda: {data.TotalProducts} | Bez zaliha: {data.OutOfStockCount}";

        var bHeaders = new[] { "Proizvod", "Kategorija", "Prodano", "Prihod (KM)" };
        AddHeaders(bestSheet, bHeaders, 4);

        for (var i = 0; i < data.BestSellers.Count; i++)
        {
            var item = data.BestSellers[i];
            var row = i + 5;
            bestSheet.Cell(row, 1).Value = item.ProductName;
            bestSheet.Cell(row, 2).Value = item.CategoryName;
            bestSheet.Cell(row, 3).Value = item.QuantitySold;
            bestSheet.Cell(row, 4).Value = item.TotalRevenue;
            bestSheet.Cell(row, 4).Style.NumberFormat.Format = "#,##0.00";
        }
        ApplyTableFormatting(bestSheet, bHeaders.Length, data.BestSellers.Count, 4);

        // Sheet 2: Stanje zaliha
        var stockSheet = workbook.Worksheets.Add("Stanje zaliha");
        var sHeaders = new[] { "Proizvod", "Kategorija", "Na stanju", "Cijena (KM)" };
        AddHeaders(stockSheet, sHeaders);

        for (var i = 0; i < data.StockLevels.Count; i++)
        {
            var item = data.StockLevels[i];
            var row = i + 2;
            stockSheet.Cell(row, 1).Value = item.ProductName;
            stockSheet.Cell(row, 2).Value = item.CategoryName;
            stockSheet.Cell(row, 3).Value = item.StockQuantity;
            stockSheet.Cell(row, 4).Value = item.Price;
            stockSheet.Cell(row, 4).Style.NumberFormat.Format = "#,##0.00";
        }
        ApplyTableFormatting(stockSheet, sHeaders.Length, data.StockLevels.Count);

        // Sheet 3: Upozorenja
        var alertSheet = workbook.Worksheets.Add("Upozorenja");
        var aHeaders = new[] { "Proizvod", "Kategorija", "Na stanju" };
        AddHeaders(alertSheet, aHeaders);

        for (var i = 0; i < data.LowStockAlerts.Count; i++)
        {
            var item = data.LowStockAlerts[i];
            var row = i + 2;
            alertSheet.Cell(row, 1).Value = item.ProductName;
            alertSheet.Cell(row, 2).Value = item.CategoryName;
            alertSheet.Cell(row, 3).Value = item.StockQuantity;
        }
        ApplyTableFormatting(alertSheet, aHeaders.Length, data.LowStockAlerts.Count);

        return SaveWorkbook(workbook);
    }

    public byte[] GenerateUserReport(UserReportData data)
    {
        using var workbook = new XLWorkbook();

        // Sheet 1: Pregled
        var summarySheet = workbook.Worksheets.Add("Pregled");
        summarySheet.Cell(1, 1).Value = "Izvještaj o korisnicima";
        summarySheet.Cell(1, 1).Style.Font.Bold = true;
        summarySheet.Cell(1, 1).Style.Font.FontSize = 14;
        summarySheet.Cell(2, 1).Value = $"Period: {data.From:dd.MM.yyyy} - {data.To:dd.MM.yyyy}";

        summarySheet.Cell(4, 1).Value = "Ukupan broj korisnika";
        summarySheet.Cell(4, 2).Value = data.TotalUsers;
        summarySheet.Cell(5, 1).Value = "Novih korisnika u periodu";
        summarySheet.Cell(5, 2).Value = data.NewUsersInPeriod;
        summarySheet.Cell(6, 1).Value = "Aktivnih korisnika u periodu";
        summarySheet.Cell(6, 2).Value = data.ActiveUsersInPeriod;
        summarySheet.Cell(7, 1).Value = "Stopa zadržavanja (%)";
        summarySheet.Cell(7, 2).Value = data.RetentionRate;
        summarySheet.Cell(7, 2).Style.NumberFormat.Format = "0.00";
        summarySheet.Columns().AdjustToContents();

        // Sheet 2: Registracije
        var regSheet = workbook.Worksheets.Add("Registracije");
        var rHeaders = new[] { "Mjesec", "Godina", "Broj registracija" };
        AddHeaders(regSheet, rHeaders);

        for (var i = 0; i < data.MonthlyRegistrations.Count; i++)
        {
            var item = data.MonthlyRegistrations[i];
            var row = i + 2;
            regSheet.Cell(row, 1).Value = item.Month;
            regSheet.Cell(row, 2).Value = item.Year;
            regSheet.Cell(row, 3).Value = item.Count;
        }
        ApplyTableFormatting(regSheet, rHeaders.Length, data.MonthlyRegistrations.Count);

        // Sheet 3: Najaktivniji
        var activeSheet = workbook.Worksheets.Add("Najaktivniji");
        var aHeaders = new[] { "Ime i prezime", "Email", "Broj posjeta", "Ukupno minuta" };
        AddHeaders(activeSheet, aHeaders);

        for (var i = 0; i < data.MostActiveUsers.Count; i++)
        {
            var item = data.MostActiveUsers[i];
            var row = i + 2;
            activeSheet.Cell(row, 1).Value = item.FullName;
            activeSheet.Cell(row, 2).Value = item.Email;
            activeSheet.Cell(row, 3).Value = item.GymVisits;
            activeSheet.Cell(row, 4).Value = item.TotalMinutes;
        }
        ApplyTableFormatting(activeSheet, aHeaders.Length, data.MostActiveUsers.Count);

        return SaveWorkbook(workbook);
    }

    public byte[] GenerateAppointmentReport(AppointmentReportData data)
    {
        using var workbook = new XLWorkbook();

        // Sheet 1: Pregled
        var summarySheet = workbook.Worksheets.Add("Pregled");
        summarySheet.Cell(1, 1).Value = "Izvještaj o terminima";
        summarySheet.Cell(1, 1).Style.Font.Bold = true;
        summarySheet.Cell(1, 1).Style.Font.FontSize = 14;
        summarySheet.Cell(2, 1).Value = $"Period: {data.From:dd.MM.yyyy} - {data.To:dd.MM.yyyy}";

        summarySheet.Cell(4, 1).Value = "Ukupan broj termina";
        summarySheet.Cell(4, 2).Value = data.TotalAppointments;
        summarySheet.Cell(5, 1).Value = "Završenih termina";
        summarySheet.Cell(5, 2).Value = data.CompletedAppointments;
        summarySheet.Cell(6, 1).Value = "Otkazanih termina";
        summarySheet.Cell(6, 2).Value = data.CancelledAppointments;
        summarySheet.Cell(7, 1).Value = "Stopa otkazivanja (%)";
        summarySheet.Cell(7, 2).Value = data.CancellationRate;
        summarySheet.Cell(7, 2).Style.NumberFormat.Format = "0.00";
        summarySheet.Columns().AdjustToContents();

        // Sheet 2: Osoblje
        var staffSheet = workbook.Worksheets.Add("Osoblje");
        var sHeaders = new[] { "Osoblje", "Tip", "Ukupno", "Završeno", "Otkazano" };
        AddHeaders(staffSheet, sHeaders);

        for (var i = 0; i < data.StaffBookings.Count; i++)
        {
            var item = data.StaffBookings[i];
            var row = i + 2;
            staffSheet.Cell(row, 1).Value = item.StaffName;
            staffSheet.Cell(row, 2).Value = item.StaffType;
            staffSheet.Cell(row, 3).Value = item.TotalBookings;
            staffSheet.Cell(row, 4).Value = item.CompletedBookings;
            staffSheet.Cell(row, 5).Value = item.CancelledBookings;
        }
        ApplyTableFormatting(staffSheet, sHeaders.Length, data.StaffBookings.Count);

        // Sheet 3: Vršni sati
        var peakSheet = workbook.Worksheets.Add("Vršni sati");
        var pHeaders = new[] { "Sat", "Broj termina" };
        AddHeaders(peakSheet, pHeaders);

        for (var i = 0; i < data.PeakHours.Count; i++)
        {
            var item = data.PeakHours[i];
            var row = i + 2;
            peakSheet.Cell(row, 1).Value = $"{item.Hour:D2}:00";
            peakSheet.Cell(row, 2).Value = item.AppointmentCount;
        }
        ApplyTableFormatting(peakSheet, pHeaders.Length, data.PeakHours.Count);

        // Sheet 4: Mjesečni pregled
        var monthlySheet = workbook.Worksheets.Add("Mjesečni pregled");
        var mHeaders = new[] { "Mjesec", "Godina", "Ukupno", "Otkazano" };
        AddHeaders(monthlySheet, mHeaders);

        for (var i = 0; i < data.MonthlyAppointments.Count; i++)
        {
            var item = data.MonthlyAppointments[i];
            var row = i + 2;
            monthlySheet.Cell(row, 1).Value = item.Month;
            monthlySheet.Cell(row, 2).Value = item.Year;
            monthlySheet.Cell(row, 3).Value = item.Count;
            monthlySheet.Cell(row, 4).Value = item.CancelledCount;
        }
        ApplyTableFormatting(monthlySheet, mHeaders.Length, data.MonthlyAppointments.Count);

        return SaveWorkbook(workbook);
    }

    public byte[] GenerateGamificationReport(GamificationReportData data)
    {
        using var workbook = new XLWorkbook();

        // Sheet 1: Pregled
        var summarySheet = workbook.Worksheets.Add("Pregled");
        summarySheet.Cell(1, 1).Value = "Izvještaj o gamifikaciji";
        summarySheet.Cell(1, 1).Style.Font.Bold = true;
        summarySheet.Cell(1, 1).Style.Font.FontSize = 14;
        summarySheet.Cell(2, 1).Value = $"Period: {data.From:dd.MM.yyyy} - {data.To:dd.MM.yyyy}";

        summarySheet.Cell(4, 1).Value = "Ukupan broj posjeta";
        summarySheet.Cell(4, 2).Value = data.TotalGymVisits;
        summarySheet.Cell(5, 1).Value = "Prosječno trajanje posjete (min)";
        summarySheet.Cell(5, 2).Value = data.AvgVisitDurationMinutes;
        summarySheet.Cell(5, 2).Style.NumberFormat.Format = "0.0";
        summarySheet.Columns().AdjustToContents();

        // Sheet 2: Raspodjela nivoa
        var levelSheet = workbook.Worksheets.Add("Raspodjela nivoa");
        var lHeaders = new[] { "Nivo", "Broj korisnika" };
        AddHeaders(levelSheet, lHeaders);

        for (var i = 0; i < data.LevelDistribution.Count; i++)
        {
            var item = data.LevelDistribution[i];
            var row = i + 2;
            levelSheet.Cell(row, 1).Value = item.LevelName;
            levelSheet.Cell(row, 2).Value = item.UserCount;
        }
        ApplyTableFormatting(levelSheet, lHeaders.Length, data.LevelDistribution.Count);

        // Sheet 3: Top korisnici
        var topSheet = workbook.Worksheets.Add("Top korisnici");
        var tHeaders = new[] { "Ime i prezime", "Email", "Nivo", "XP", "Ukupno minuta" };
        AddHeaders(topSheet, tHeaders);

        for (var i = 0; i < data.TopUsers.Count; i++)
        {
            var item = data.TopUsers[i];
            var row = i + 2;
            topSheet.Cell(row, 1).Value = item.FullName;
            topSheet.Cell(row, 2).Value = item.Email;
            topSheet.Cell(row, 3).Value = item.Level;
            topSheet.Cell(row, 4).Value = item.XP;
            topSheet.Cell(row, 5).Value = item.TotalGymMinutes;
        }
        ApplyTableFormatting(topSheet, tHeaders.Length, data.TopUsers.Count);

        // Sheet 4: Dnevne posjete
        var dailySheet = workbook.Worksheets.Add("Dnevne posjete");
        var dHeaders = new[] { "Datum", "Broj posjeta", "Prosječno trajanje (min)" };
        AddHeaders(dailySheet, dHeaders);

        for (var i = 0; i < data.DailyVisits.Count; i++)
        {
            var item = data.DailyVisits[i];
            var row = i + 2;
            dailySheet.Cell(row, 1).Value = item.Date.ToString("dd.MM.yyyy");
            dailySheet.Cell(row, 2).Value = item.VisitCount;
            dailySheet.Cell(row, 3).Value = item.AvgDurationMinutes;
            dailySheet.Cell(row, 3).Style.NumberFormat.Format = "0.0";
        }
        ApplyTableFormatting(dailySheet, dHeaders.Length, data.DailyVisits.Count);

        return SaveWorkbook(workbook);
    }

    private static void AddHeaders(IXLWorksheet sheet, string[] headers, int startRow = 1)
    {
        for (var i = 0; i < headers.Length; i++)
        {
            var cell = sheet.Cell(startRow, i + 1);
            cell.Value = headers[i];
            cell.Style.Font.Bold = true;
            cell.Style.Fill.BackgroundColor = XLColor.DarkBlue;
            cell.Style.Font.FontColor = XLColor.White;
        }
    }

    private static void ApplyTableFormatting(IXLWorksheet sheet, int columnCount, int dataRowCount, int headerRow = 1)
    {
        if (dataRowCount > 0)
        {
            var range = sheet.Range(headerRow, 1, headerRow + dataRowCount, columnCount);
            range.SetAutoFilter();
        }
        sheet.Columns().AdjustToContents();
    }

    private static byte[] SaveWorkbook(XLWorkbook workbook)
    {
        using var stream = new MemoryStream();
        workbook.SaveAs(stream);
        return stream.ToArray();
    }
}
