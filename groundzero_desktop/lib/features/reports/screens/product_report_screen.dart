import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/constants/app_colors.dart';
import '../providers/product_report_provider.dart';
import '../widgets/report_bar_chart.dart';
import '../widgets/report_data_table.dart';
import '../widgets/report_kpi_card.dart';
import '../widgets/report_screen_layout.dart';
import '../widgets/report_section_header.dart';

class ProductReportScreen extends ConsumerWidget {
  const ProductReportScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(productReportProvider);
    final notifier = ref.read(productReportProvider.notifier);
    final currFmt = NumberFormat('#,##0.00', 'bs');

    return ReportScreenLayout(
      title: 'Izvještaj — Proizvodi',
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
                      icon: Icons.inventory_2,
                      value: state.data!.totalProducts.toString(),
                      label: 'Ukupno proizvoda',
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ReportKpiCard(
                      icon: Icons.remove_shopping_cart,
                      value: state.data!.outOfStockCount.toString(),
                      label: 'Nema na stanju',
                      valueColor: state.data!.outOfStockCount > 0
                          ? AppColors.error
                          : null,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ReportKpiCard(
                      icon: Icons.warning_amber,
                      value: state.data!.lowStockAlerts.length.toString(),
                      label: 'Nisko stanje',
                      valueColor: state.data!.lowStockAlerts.isNotEmpty
                          ? AppColors.warning
                          : null,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 28),

              // Best sellers chart
              const ReportSectionHeader(title: 'Najprodavaniji proizvodi'),
              SizedBox(
                height: 280,
                child: ReportBarChart(
                  labels: state.data!.bestSellers
                      .take(10)
                      .map((e) => e.productName.length > 12
                          ? '${e.productName.substring(0, 10)}...'
                          : e.productName)
                      .toList(),
                  values: state.data!.bestSellers
                      .take(10)
                      .map((e) => e.quantitySold.toDouble())
                      .toList(),
                  tooltipSuffix: ' kom',
                ),
              ),
              const SizedBox(height: 28),

              // Stock levels table
              const ReportSectionHeader(title: 'Stanje zaliha'),
              ReportDataTable(
                columns: const ['Proizvod', 'Kategorija', 'Stanje', 'Cijena (KM)'],
                rows: state.data!.stockLevels
                    .map(
                      (s) => DataRow(cells: [
                        DataCell(Text(s.productName)),
                        DataCell(Text(s.categoryName)),
                        DataCell(Text(
                          s.stockQuantity.toString(),
                          style: TextStyle(
                            color: s.stockQuantity == 0
                                ? AppColors.error
                                : s.stockQuantity < 10
                                    ? AppColors.warning
                                    : null,
                          ),
                        )),
                        DataCell(Text(currFmt.format(s.price))),
                      ]),
                    )
                    .toList(),
              ),

              if (state.data!.lowStockAlerts.isNotEmpty) ...[
                const SizedBox(height: 28),
                const ReportSectionHeader(title: 'Upozorenja — Nisko stanje'),
                ReportDataTable(
                  columns: const ['Proizvod', 'Kategorija', 'Stanje'],
                  rows: state.data!.lowStockAlerts
                      .map(
                        (a) => DataRow(cells: [
                          DataCell(Text(a.productName)),
                          DataCell(Text(a.categoryName)),
                          DataCell(Text(
                            a.stockQuantity.toString(),
                            style: const TextStyle(color: AppColors.warning),
                          )),
                        ]),
                      )
                      .toList(),
                ),
              ],
            ],
    );
  }
}
