using GroundZero.Application.Features.Reports.DTOs;
using GroundZero.Application.IServices;
using QuestPDF.Fluent;
using QuestPDF.Helpers;
using QuestPDF.Infrastructure;

namespace GroundZero.Infrastructure.Services;

public class PdfReportService : IPdfReportService
{
    public byte[] GenerateRevenueReport(RevenueReportData data)
    {
        return Document.Create(container =>
        {
            container.Page(page =>
            {
                page.Size(PageSizes.A4);
                page.Margin(30);
                page.DefaultTextStyle(x => x.FontSize(10));

                page.Header().Element(h => ComposeHeader(h, "Izvještaj o prihodima", data.From, data.To));

                page.Content().Column(col =>
                {
                    col.Spacing(15);

                    col.Item().Text("Pregled").Bold().FontSize(14);
                    col.Item().Table(table =>
                    {
                        table.ColumnsDefinition(columns =>
                        {
                            columns.RelativeColumn();
                            columns.RelativeColumn();
                        });

                        AddSummaryRow(table, "Ukupni prihod od narudžbi", $"{data.TotalOrderRevenue:N2} KM");
                        AddSummaryRow(table, "Ukupan broj narudžbi", data.TotalOrders.ToString());
                        AddSummaryRow(table, "Ukupan broj termina", data.TotalAppointments.ToString());
                    });

                    if (data.MonthlyRevenue.Any())
                    {
                        col.Item().Text("Mjesečni pregled prihoda").Bold().FontSize(14);
                        col.Item().Table(table =>
                        {
                            table.ColumnsDefinition(columns =>
                            {
                                columns.RelativeColumn(2);
                                columns.RelativeColumn();
                                columns.RelativeColumn(2);
                                columns.RelativeColumn();
                            });

                            ComposeTableHeader(table, "Mjesec", "Godina", "Prihod (KM)", "Br. narudžbi");

                            foreach (var item in data.MonthlyRevenue)
                            {
                                table.Cell().BorderBottom(1).BorderColor(Colors.Grey.Lighten2).Padding(4).Text(item.Month);
                                table.Cell().BorderBottom(1).BorderColor(Colors.Grey.Lighten2).Padding(4).Text(item.Year.ToString());
                                table.Cell().BorderBottom(1).BorderColor(Colors.Grey.Lighten2).Padding(4).AlignRight().Text($"{item.Revenue:N2}");
                                table.Cell().BorderBottom(1).BorderColor(Colors.Grey.Lighten2).Padding(4).AlignRight().Text(item.OrderCount.ToString());
                            }
                        });
                    }

                    if (data.CategoryRevenue.Any())
                    {
                        col.Item().Text("Prihod po kategorijama").Bold().FontSize(14);
                        col.Item().Table(table =>
                        {
                            table.ColumnsDefinition(columns =>
                            {
                                columns.RelativeColumn(3);
                                columns.RelativeColumn(2);
                                columns.RelativeColumn();
                            });

                            ComposeTableHeader(table, "Kategorija", "Prihod (KM)", "Prodano kom.");

                            foreach (var item in data.CategoryRevenue)
                            {
                                table.Cell().BorderBottom(1).BorderColor(Colors.Grey.Lighten2).Padding(4).Text(item.CategoryName);
                                table.Cell().BorderBottom(1).BorderColor(Colors.Grey.Lighten2).Padding(4).AlignRight().Text($"{item.Revenue:N2}");
                                table.Cell().BorderBottom(1).BorderColor(Colors.Grey.Lighten2).Padding(4).AlignRight().Text(item.ItemsSold.ToString());
                            }
                        });
                    }
                });

                page.Footer().Element(ComposeFooter);
            });
        }).GeneratePdf();
    }

    public byte[] GenerateProductReport(ProductReportData data)
    {
        return Document.Create(container =>
        {
            container.Page(page =>
            {
                page.Size(PageSizes.A4);
                page.Margin(30);
                page.DefaultTextStyle(x => x.FontSize(10));

                page.Header().Element(h => ComposeHeader(h, "Izvještaj o proizvodima", data.From, data.To));

                page.Content().Column(col =>
                {
                    col.Spacing(15);

                    col.Item().Text("Pregled").Bold().FontSize(14);
                    col.Item().Table(table =>
                    {
                        table.ColumnsDefinition(columns =>
                        {
                            columns.RelativeColumn();
                            columns.RelativeColumn();
                        });

                        AddSummaryRow(table, "Ukupan broj proizvoda", data.TotalProducts.ToString());
                        AddSummaryRow(table, "Proizvoda bez zaliha", data.OutOfStockCount.ToString());
                    });

                    if (data.BestSellers.Any())
                    {
                        col.Item().Text("Najtraženiji proizvodi").Bold().FontSize(14);
                        col.Item().Table(table =>
                        {
                            table.ColumnsDefinition(columns =>
                            {
                                columns.RelativeColumn(3);
                                columns.RelativeColumn(2);
                                columns.RelativeColumn();
                                columns.RelativeColumn(2);
                            });

                            ComposeTableHeader(table, "Proizvod", "Kategorija", "Prodano", "Prihod (KM)");

                            foreach (var item in data.BestSellers)
                            {
                                table.Cell().BorderBottom(1).BorderColor(Colors.Grey.Lighten2).Padding(4).Text(item.ProductName);
                                table.Cell().BorderBottom(1).BorderColor(Colors.Grey.Lighten2).Padding(4).Text(item.CategoryName);
                                table.Cell().BorderBottom(1).BorderColor(Colors.Grey.Lighten2).Padding(4).AlignRight().Text(item.QuantitySold.ToString());
                                table.Cell().BorderBottom(1).BorderColor(Colors.Grey.Lighten2).Padding(4).AlignRight().Text($"{item.TotalRevenue:N2}");
                            }
                        });
                    }

                    if (data.LowStockAlerts.Any())
                    {
                        col.Item().Text("Upozorenja - nizak nivo zaliha").Bold().FontSize(14).FontColor(Colors.Red.Medium);
                        col.Item().Table(table =>
                        {
                            table.ColumnsDefinition(columns =>
                            {
                                columns.RelativeColumn(3);
                                columns.RelativeColumn(2);
                                columns.RelativeColumn();
                            });

                            ComposeTableHeader(table, "Proizvod", "Kategorija", "Na stanju");

                            foreach (var item in data.LowStockAlerts)
                            {
                                table.Cell().BorderBottom(1).BorderColor(Colors.Grey.Lighten2).Padding(4).Text(item.ProductName);
                                table.Cell().BorderBottom(1).BorderColor(Colors.Grey.Lighten2).Padding(4).Text(item.CategoryName);
                                table.Cell().BorderBottom(1).BorderColor(Colors.Grey.Lighten2).Padding(4).AlignRight()
                                    .Text(item.StockQuantity.ToString()).FontColor(Colors.Red.Medium);
                            }
                        });
                    }
                });

                page.Footer().Element(ComposeFooter);
            });
        }).GeneratePdf();
    }

    public byte[] GenerateUserReport(UserReportData data)
    {
        return Document.Create(container =>
        {
            container.Page(page =>
            {
                page.Size(PageSizes.A4);
                page.Margin(30);
                page.DefaultTextStyle(x => x.FontSize(10));

                page.Header().Element(h => ComposeHeader(h, "Izvještaj o korisnicima", data.From, data.To));

                page.Content().Column(col =>
                {
                    col.Spacing(15);

                    col.Item().Text("Pregled").Bold().FontSize(14);
                    col.Item().Table(table =>
                    {
                        table.ColumnsDefinition(columns =>
                        {
                            columns.RelativeColumn();
                            columns.RelativeColumn();
                        });

                        AddSummaryRow(table, "Ukupan broj korisnika", data.TotalUsers.ToString());
                        AddSummaryRow(table, "Novih korisnika u periodu", data.NewUsersInPeriod.ToString());
                        AddSummaryRow(table, "Aktivnih korisnika u periodu", data.ActiveUsersInPeriod.ToString());
                        AddSummaryRow(table, "Stopa zadržavanja", $"{data.RetentionRate:N2}%");
                    });

                    if (data.MonthlyRegistrations.Any())
                    {
                        col.Item().Text("Mjesečne registracije").Bold().FontSize(14);
                        col.Item().Table(table =>
                        {
                            table.ColumnsDefinition(columns =>
                            {
                                columns.RelativeColumn(2);
                                columns.RelativeColumn();
                                columns.RelativeColumn();
                            });

                            ComposeTableHeader(table, "Mjesec", "Godina", "Broj registracija");

                            foreach (var item in data.MonthlyRegistrations)
                            {
                                table.Cell().BorderBottom(1).BorderColor(Colors.Grey.Lighten2).Padding(4).Text(item.Month);
                                table.Cell().BorderBottom(1).BorderColor(Colors.Grey.Lighten2).Padding(4).Text(item.Year.ToString());
                                table.Cell().BorderBottom(1).BorderColor(Colors.Grey.Lighten2).Padding(4).AlignRight().Text(item.Count.ToString());
                            }
                        });
                    }

                    if (data.MostActiveUsers.Any())
                    {
                        col.Item().Text("Najaktivniji korisnici").Bold().FontSize(14);
                        col.Item().Table(table =>
                        {
                            table.ColumnsDefinition(columns =>
                            {
                                columns.RelativeColumn(3);
                                columns.RelativeColumn(3);
                                columns.RelativeColumn();
                                columns.RelativeColumn(2);
                            });

                            ComposeTableHeader(table, "Ime i prezime", "Email", "Posjeta", "Ukupno minuta");

                            foreach (var item in data.MostActiveUsers)
                            {
                                table.Cell().BorderBottom(1).BorderColor(Colors.Grey.Lighten2).Padding(4).Text(item.FullName);
                                table.Cell().BorderBottom(1).BorderColor(Colors.Grey.Lighten2).Padding(4).Text(item.Email);
                                table.Cell().BorderBottom(1).BorderColor(Colors.Grey.Lighten2).Padding(4).AlignRight().Text(item.GymVisits.ToString());
                                table.Cell().BorderBottom(1).BorderColor(Colors.Grey.Lighten2).Padding(4).AlignRight().Text(item.TotalMinutes.ToString());
                            }
                        });
                    }
                });

                page.Footer().Element(ComposeFooter);
            });
        }).GeneratePdf();
    }

    public byte[] GenerateAppointmentReport(AppointmentReportData data)
    {
        return Document.Create(container =>
        {
            container.Page(page =>
            {
                page.Size(PageSizes.A4);
                page.Margin(30);
                page.DefaultTextStyle(x => x.FontSize(10));

                page.Header().Element(h => ComposeHeader(h, "Izvještaj o terminima", data.From, data.To));

                page.Content().Column(col =>
                {
                    col.Spacing(15);

                    col.Item().Text("Pregled").Bold().FontSize(14);
                    col.Item().Table(table =>
                    {
                        table.ColumnsDefinition(columns =>
                        {
                            columns.RelativeColumn();
                            columns.RelativeColumn();
                        });

                        AddSummaryRow(table, "Ukupan broj termina", data.TotalAppointments.ToString());
                        AddSummaryRow(table, "Završenih termina", data.CompletedAppointments.ToString());
                        AddSummaryRow(table, "Otkazanih termina", data.CancelledAppointments.ToString());
                        AddSummaryRow(table, "Stopa otkazivanja", $"{data.CancellationRate:N2}%");
                    });

                    if (data.StaffBookings.Any())
                    {
                        col.Item().Text("Osoblje - pregled rezervacija").Bold().FontSize(14);
                        col.Item().Table(table =>
                        {
                            table.ColumnsDefinition(columns =>
                            {
                                columns.RelativeColumn(3);
                                columns.RelativeColumn(2);
                                columns.RelativeColumn();
                                columns.RelativeColumn();
                                columns.RelativeColumn();
                            });

                            ComposeTableHeader(table, "Osoblje", "Tip", "Ukupno", "Završeno", "Otkazano");

                            foreach (var item in data.StaffBookings)
                            {
                                table.Cell().BorderBottom(1).BorderColor(Colors.Grey.Lighten2).Padding(4).Text(item.StaffName);
                                table.Cell().BorderBottom(1).BorderColor(Colors.Grey.Lighten2).Padding(4).Text(item.StaffType);
                                table.Cell().BorderBottom(1).BorderColor(Colors.Grey.Lighten2).Padding(4).AlignRight().Text(item.TotalBookings.ToString());
                                table.Cell().BorderBottom(1).BorderColor(Colors.Grey.Lighten2).Padding(4).AlignRight().Text(item.CompletedBookings.ToString());
                                table.Cell().BorderBottom(1).BorderColor(Colors.Grey.Lighten2).Padding(4).AlignRight().Text(item.CancelledBookings.ToString());
                            }
                        });
                    }

                    if (data.PeakHours.Any())
                    {
                        col.Item().Text("Vršni sati").Bold().FontSize(14);
                        col.Item().Table(table =>
                        {
                            table.ColumnsDefinition(columns =>
                            {
                                columns.RelativeColumn(2);
                                columns.RelativeColumn();
                            });

                            ComposeTableHeader(table, "Sat", "Broj termina");

                            foreach (var item in data.PeakHours)
                            {
                                table.Cell().BorderBottom(1).BorderColor(Colors.Grey.Lighten2).Padding(4).Text($"{item.Hour:D2}:00");
                                table.Cell().BorderBottom(1).BorderColor(Colors.Grey.Lighten2).Padding(4).AlignRight().Text(item.AppointmentCount.ToString());
                            }
                        });
                    }

                    if (data.MonthlyAppointments.Any())
                    {
                        col.Item().Text("Mjesečni pregled termina").Bold().FontSize(14);
                        col.Item().Table(table =>
                        {
                            table.ColumnsDefinition(columns =>
                            {
                                columns.RelativeColumn(2);
                                columns.RelativeColumn();
                                columns.RelativeColumn();
                                columns.RelativeColumn();
                            });

                            ComposeTableHeader(table, "Mjesec", "Godina", "Ukupno", "Otkazano");

                            foreach (var item in data.MonthlyAppointments)
                            {
                                table.Cell().BorderBottom(1).BorderColor(Colors.Grey.Lighten2).Padding(4).Text(item.Month);
                                table.Cell().BorderBottom(1).BorderColor(Colors.Grey.Lighten2).Padding(4).Text(item.Year.ToString());
                                table.Cell().BorderBottom(1).BorderColor(Colors.Grey.Lighten2).Padding(4).AlignRight().Text(item.Count.ToString());
                                table.Cell().BorderBottom(1).BorderColor(Colors.Grey.Lighten2).Padding(4).AlignRight().Text(item.CancelledCount.ToString());
                            }
                        });
                    }
                });

                page.Footer().Element(ComposeFooter);
            });
        }).GeneratePdf();
    }

    public byte[] GenerateGamificationReport(GamificationReportData data)
    {
        return Document.Create(container =>
        {
            container.Page(page =>
            {
                page.Size(PageSizes.A4);
                page.Margin(30);
                page.DefaultTextStyle(x => x.FontSize(10));

                page.Header().Element(h => ComposeHeader(h, "Izvještaj o gamifikaciji", data.From, data.To));

                page.Content().Column(col =>
                {
                    col.Spacing(15);

                    col.Item().Text("Pregled").Bold().FontSize(14);
                    col.Item().Table(table =>
                    {
                        table.ColumnsDefinition(columns =>
                        {
                            columns.RelativeColumn();
                            columns.RelativeColumn();
                        });

                        AddSummaryRow(table, "Ukupan broj posjeta", data.TotalGymVisits.ToString());
                        AddSummaryRow(table, "Prosječno trajanje posjete (min)", $"{data.AvgVisitDurationMinutes:N1}");
                    });

                    if (data.LevelDistribution.Any())
                    {
                        col.Item().Text("Raspodjela nivoa").Bold().FontSize(14);
                        col.Item().Table(table =>
                        {
                            table.ColumnsDefinition(columns =>
                            {
                                columns.RelativeColumn(3);
                                columns.RelativeColumn();
                            });

                            ComposeTableHeader(table, "Nivo", "Broj korisnika");

                            foreach (var item in data.LevelDistribution)
                            {
                                table.Cell().BorderBottom(1).BorderColor(Colors.Grey.Lighten2).Padding(4).Text(item.LevelName);
                                table.Cell().BorderBottom(1).BorderColor(Colors.Grey.Lighten2).Padding(4).AlignRight().Text(item.UserCount.ToString());
                            }
                        });
                    }

                    if (data.TopUsers.Any())
                    {
                        col.Item().Text("Top korisnici").Bold().FontSize(14);
                        col.Item().Table(table =>
                        {
                            table.ColumnsDefinition(columns =>
                            {
                                columns.RelativeColumn(3);
                                columns.RelativeColumn(3);
                                columns.RelativeColumn();
                                columns.RelativeColumn();
                                columns.RelativeColumn(2);
                            });

                            ComposeTableHeader(table, "Ime i prezime", "Email", "Nivo", "XP", "Ukupno min.");

                            foreach (var item in data.TopUsers)
                            {
                                table.Cell().BorderBottom(1).BorderColor(Colors.Grey.Lighten2).Padding(4).Text(item.FullName);
                                table.Cell().BorderBottom(1).BorderColor(Colors.Grey.Lighten2).Padding(4).Text(item.Email);
                                table.Cell().BorderBottom(1).BorderColor(Colors.Grey.Lighten2).Padding(4).AlignRight().Text(item.Level.ToString());
                                table.Cell().BorderBottom(1).BorderColor(Colors.Grey.Lighten2).Padding(4).AlignRight().Text(item.XP.ToString());
                                table.Cell().BorderBottom(1).BorderColor(Colors.Grey.Lighten2).Padding(4).AlignRight().Text(item.TotalGymMinutes.ToString());
                            }
                        });
                    }

                    if (data.DailyVisits.Any())
                    {
                        col.Item().Text("Dnevne posjete").Bold().FontSize(14);
                        col.Item().Table(table =>
                        {
                            table.ColumnsDefinition(columns =>
                            {
                                columns.RelativeColumn(2);
                                columns.RelativeColumn();
                                columns.RelativeColumn(2);
                            });

                            ComposeTableHeader(table, "Datum", "Br. posjeta", "Prosj. trajanje (min)");

                            foreach (var item in data.DailyVisits)
                            {
                                table.Cell().BorderBottom(1).BorderColor(Colors.Grey.Lighten2).Padding(4).Text(item.Date.ToString("dd.MM.yyyy"));
                                table.Cell().BorderBottom(1).BorderColor(Colors.Grey.Lighten2).Padding(4).AlignRight().Text(item.VisitCount.ToString());
                                table.Cell().BorderBottom(1).BorderColor(Colors.Grey.Lighten2).Padding(4).AlignRight().Text($"{item.AvgDurationMinutes:N1}");
                            }
                        });
                    }
                });

                page.Footer().Element(ComposeFooter);
            });
        }).GeneratePdf();
    }

    private static void ComposeHeader(IContainer container, string title, DateTime from, DateTime to)
    {
        container.Column(col =>
        {
            col.Item().Text("GroundZero Gym").Bold().FontSize(20).FontColor(Colors.Blue.Darken2);
            col.Item().Text(title).FontSize(16).SemiBold();
            col.Item().Text($"Period: {from:dd.MM.yyyy} - {to:dd.MM.yyyy}").FontSize(10).FontColor(Colors.Grey.Darken1);
            col.Item().PaddingTop(5).LineHorizontal(1).LineColor(Colors.Grey.Lighten1);
        });
    }

    private static void ComposeFooter(IContainer container)
    {
        container.Column(col =>
        {
            col.Item().LineHorizontal(1).LineColor(Colors.Grey.Lighten1);
            col.Item().PaddingTop(5).Row(row =>
            {
                row.RelativeItem().Text($"Generirano: {DateTime.UtcNow:dd.MM.yyyy HH:mm} UTC").FontSize(8).FontColor(Colors.Grey.Darken1);
                row.RelativeItem().AlignRight().Text(text =>
                {
                    text.Span("Stranica ").FontSize(8);
                    text.CurrentPageNumber().FontSize(8);
                    text.Span(" / ").FontSize(8);
                    text.TotalPages().FontSize(8);
                });
            });
        });
    }

    private static void ComposeTableHeader(TableDescriptor table, params string[] headers)
    {
        foreach (var header in headers)
        {
            table.Cell().Background(Colors.Blue.Darken2).Padding(4)
                .Text(header).FontColor(Colors.White).Bold().FontSize(9);
        }
    }

    private static void AddSummaryRow(TableDescriptor table, string label, string value)
    {
        table.Cell().BorderBottom(1).BorderColor(Colors.Grey.Lighten2).Padding(4).Text(label).SemiBold();
        table.Cell().BorderBottom(1).BorderColor(Colors.Grey.Lighten2).Padding(4).AlignRight().Text(value);
    }
}
