import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/user_report_provider.dart';
import '../widgets/report_bar_chart.dart';
import '../widgets/report_data_table.dart';
import '../widgets/report_kpi_card.dart';
import '../widgets/report_screen_layout.dart';
import '../widgets/report_section_header.dart';

class UserReportScreen extends ConsumerWidget {
  const UserReportScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(userReportProvider);
    final notifier = ref.read(userReportProvider.notifier);

    return ReportScreenLayout(
      title: 'Izvještaj — Korisnici',
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
                      icon: Icons.people,
                      value: state.data!.totalUsers.toString(),
                      label: 'Ukupno korisnika',
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ReportKpiCard(
                      icon: Icons.person_add,
                      value: state.data!.newUsersInPeriod.toString(),
                      label: 'Novi korisnici',
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ReportKpiCard(
                      icon: Icons.directions_run,
                      value: state.data!.activeUsersInPeriod.toString(),
                      label: 'Aktivni korisnici',
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ReportKpiCard(
                      icon: Icons.repeat,
                      value: '${state.data!.retentionRate.toStringAsFixed(1)}%',
                      label: 'Retencija',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 28),

              // Monthly registrations chart
              const ReportSectionHeader(title: 'Mjesečne registracije'),
              SizedBox(
                height: 280,
                child: ReportBarChart(
                  labels: state.data!.monthlyRegistrations
                      .map((e) => '${e.month.substring(0, 3)}\n${e.year}')
                      .toList(),
                  values: state.data!.monthlyRegistrations
                      .map((e) => e.count.toDouble())
                      .toList(),
                ),
              ),
              const SizedBox(height: 28),

              // Most active users table
              const ReportSectionHeader(title: 'Najaktivniji korisnici'),
              ReportDataTable(
                columns: const ['Ime', 'Email', 'Posjete', 'Ukupno minuta'],
                rows: state.data!.mostActiveUsers
                    .map(
                      (u) => DataRow(cells: [
                        DataCell(Text(u.fullName)),
                        DataCell(Text(u.email)),
                        DataCell(Text(u.gymVisits.toString())),
                        DataCell(Text(u.totalMinutes.toString())),
                      ]),
                    )
                    .toList(),
              ),
            ],
    );
  }
}
