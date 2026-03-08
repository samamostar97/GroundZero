import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../providers/gamification_report_provider.dart';
import '../widgets/report_bar_chart.dart';
import '../widgets/report_data_table.dart';
import '../widgets/report_kpi_card.dart';
import '../widgets/report_screen_layout.dart';
import '../widgets/report_section_header.dart';

class GamificationReportScreen extends ConsumerWidget {
  const GamificationReportScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(gamificationReportProvider);
    final notifier = ref.read(gamificationReportProvider.notifier);
    final dateFmt = DateFormat('dd.MM.yyyy');

    return ReportScreenLayout(
      title: 'Izvještaj — Gamifikacija',
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
                      icon: Icons.fitness_center,
                      value: state.data!.totalGymVisits.toString(),
                      label: 'Ukupno posjeta',
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ReportKpiCard(
                      icon: Icons.timer,
                      value:
                          '${state.data!.avgVisitDurationMinutes.toStringAsFixed(0)} min',
                      label: 'Prosj. trajanje posjete',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 28),

              // Level distribution chart
              const ReportSectionHeader(title: 'Distribucija nivoa'),
              SizedBox(
                height: 250,
                child: ReportBarChart(
                  labels: state.data!.levelDistribution
                      .map((e) => e.levelName)
                      .toList(),
                  values: state.data!.levelDistribution
                      .map((e) => e.userCount.toDouble())
                      .toList(),
                ),
              ),
              const SizedBox(height: 28),

              // Top users table
              const ReportSectionHeader(title: 'Top korisnici'),
              ReportDataTable(
                columns: const ['Ime', 'Email', 'Nivo', 'XP', 'Minuta'],
                rows: state.data!.topUsers
                    .map(
                      (u) => DataRow(cells: [
                        DataCell(Text(u.fullName)),
                        DataCell(Text(u.email)),
                        DataCell(Text(u.level.toString())),
                        DataCell(Text(u.xp.toString())),
                        DataCell(Text(u.totalGymMinutes.toString())),
                      ]),
                    )
                    .toList(),
              ),
            ],
    );
  }
}
