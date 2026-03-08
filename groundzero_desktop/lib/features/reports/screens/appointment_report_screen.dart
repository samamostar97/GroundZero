import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_colors.dart';
import '../providers/appointment_report_provider.dart';
import '../widgets/report_bar_chart.dart';
import '../widgets/report_data_table.dart';
import '../widgets/report_kpi_card.dart';
import '../widgets/report_screen_layout.dart';
import '../widgets/report_section_header.dart';

class AppointmentReportScreen extends ConsumerWidget {
  const AppointmentReportScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(appointmentReportProvider);
    final notifier = ref.read(appointmentReportProvider.notifier);

    return ReportScreenLayout(
      title: 'Izvještaj — Termini',
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
                      icon: Icons.event,
                      value: state.data!.totalAppointments.toString(),
                      label: 'Ukupno termina',
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ReportKpiCard(
                      icon: Icons.check_circle,
                      value: state.data!.completedAppointments.toString(),
                      label: 'Završeni',
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ReportKpiCard(
                      icon: Icons.cancel,
                      value: state.data!.cancelledAppointments.toString(),
                      label: 'Otkazani',
                      valueColor: state.data!.cancelledAppointments > 0
                          ? AppColors.error
                          : null,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ReportKpiCard(
                      icon: Icons.percent,
                      value:
                          '${state.data!.cancellationRate.toStringAsFixed(1)}%',
                      label: 'Stopa otkazivanja',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 28),

              // Monthly appointments chart
              const ReportSectionHeader(title: 'Mjesečni termini'),
              SizedBox(
                height: 280,
                child: ReportBarChart(
                  labels: state.data!.monthlyAppointments
                      .map((e) => '${e.month.substring(0, 3)}\n${e.year}')
                      .toList(),
                  values: state.data!.monthlyAppointments
                      .map((e) => e.count.toDouble())
                      .toList(),
                ),
              ),
              const SizedBox(height: 28),

              // Peak hours chart
              const ReportSectionHeader(title: 'Najpopularniji sati'),
              SizedBox(
                height: 250,
                child: ReportBarChart(
                  labels: state.data!.peakHours
                      .map((e) => '${e.hour}h')
                      .toList(),
                  values: state.data!.peakHours
                      .map((e) => e.appointmentCount.toDouble())
                      .toList(),
                  barColor: AppColors.accentDark,
                  barWidth: 14,
                ),
              ),
              const SizedBox(height: 28),

              // Staff bookings table
              const ReportSectionHeader(title: 'Rezervacije po osoblju'),
              ReportDataTable(
                columns: const [
                  'Osoblje',
                  'Tip',
                  'Ukupno',
                  'Završeni',
                  'Otkazani',
                ],
                rows: state.data!.staffBookings
                    .map(
                      (s) => DataRow(cells: [
                        DataCell(Text(s.staffName)),
                        DataCell(Text(s.staffType)),
                        DataCell(Text(s.totalBookings.toString())),
                        DataCell(Text(s.completedBookings.toString())),
                        DataCell(Text(
                          s.cancelledBookings.toString(),
                          style: TextStyle(
                            color: s.cancelledBookings > 0
                                ? AppColors.error
                                : null,
                          ),
                        )),
                      ]),
                    )
                    .toList(),
              ),
            ],
    );
  }
}
