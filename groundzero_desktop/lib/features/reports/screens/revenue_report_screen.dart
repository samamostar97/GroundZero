import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../providers/revenue_report_provider.dart';
import '../widgets/report_bar_chart.dart';
import '../widgets/report_data_table.dart';
import '../widgets/report_kpi_card.dart';
import '../widgets/report_screen_layout.dart';
import '../widgets/report_section_header.dart';

class RevenueReportScreen extends ConsumerWidget {
  const RevenueReportScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(revenueReportProvider);
    final notifier = ref.read(revenueReportProvider.notifier);
    final currFmt = NumberFormat('#,##0.00', 'bs');

    return ReportScreenLayout(
      title: 'Izvještaj — Prihodi',
      from: state.from,
      to: state.to,
      onFromChanged: notifier.setFrom,
      onToChanged: notifier.setTo,
      onApply: notifier.loadData,
      isExporting: state.isExporting,
      onExportPdf: () => notifier.exportReport('Pdf', context),
      onExportExcel: () => notifier.exportReport('Excel', context),
      isLoading: state.isLoading,
      error: state.error,
      onRetry: notifier.loadData,
      children: state.data == null
          ? []
          : [
              // KPIs
              Row(
                children: [
                  Expanded(
                    child: ReportKpiCard(
                      icon: Icons.attach_money,
                      value: '${currFmt.format(state.data!.totalOrderRevenue)} KM',
                      label: 'Ukupni prihod',
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ReportKpiCard(
                      icon: Icons.shopping_cart,
                      value: state.data!.totalOrders.toString(),
                      label: 'Narudžbe',
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ReportKpiCard(
                      icon: Icons.calendar_month,
                      value: state.data!.totalAppointments.toString(),
                      label: 'Termini',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 28),

              // Monthly revenue chart
              const ReportSectionHeader(title: 'Mjesečni prihod'),
              SizedBox(
                height: 280,
                child: ReportBarChart(
                  labels: state.data!.monthlyRevenue
                      .map((e) => '${e.month.substring(0, 3)}\n${e.year}')
                      .toList(),
                  values: state.data!.monthlyRevenue
                      .map((e) => e.revenue)
                      .toList(),
                  tooltipSuffix: ' KM',
                ),
              ),
              const SizedBox(height: 28),

              // Category breakdown table
              const ReportSectionHeader(title: 'Prihod po kategorijama'),
              ReportDataTable(
                columns: const ['Kategorija', 'Prihod (KM)', 'Prodano'],
                rows: state.data!.categoryRevenue
                    .map(
                      (c) => DataRow(cells: [
                        DataCell(Text(c.categoryName)),
                        DataCell(Text(currFmt.format(c.revenue))),
                        DataCell(Text(c.itemsSold.toString())),
                      ]),
                    )
                    .toList(),
              ),
            ],
    );
  }
}
