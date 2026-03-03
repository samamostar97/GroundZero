import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../shared/widgets/appointment_status_badge.dart';
import '../../../shared/widgets/error_display.dart';
import '../models/appointment_model.dart';
import '../providers/appointment_provider.dart';

class AppointmentDetailScreen extends ConsumerWidget {
  final int appointmentId;

  const AppointmentDetailScreen({super.key, required this.appointmentId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appointmentAsync =
        ref.watch(appointmentDetailProvider(appointmentId));
    final cancelState = ref.watch(cancelAppointmentProvider);

    ref.listen(cancelAppointmentProvider, (prev, next) {
      if (next is CancelAppointmentSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Termin je uspješno otkazan.',
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
            backgroundColor: AppColors.success,
          ),
        );
        ref.read(cancelAppointmentProvider.notifier).reset();
        ref.invalidate(appointmentDetailProvider(appointmentId));
      } else if (next is CancelAppointmentError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              next.message,
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
            backgroundColor: AppColors.error,
          ),
        );
        ref.read(cancelAppointmentProvider.notifier).reset();
      }
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Detalji termina', style: AppTextStyles.heading3),
      ),
      body: appointmentAsync.when(
        loading: () => const Center(
          child: CircularProgressIndicator(color: AppColors.accent),
        ),
        error: (_, _) => ErrorDisplay(
          message: 'Greška pri učitavanju termina.',
          onRetry: () =>
              ref.invalidate(appointmentDetailProvider(appointmentId)),
        ),
        data: (appointment) {
          final canCancel = appointment.status == 'Pending' ||
              appointment.status == 'Confirmed';
          final isCancelling = cancelState is CancelAppointmentLoading;

          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              // Status section
              _buildStatusSection(appointment),
              const SizedBox(height: 20),

              // Staff info
              Text('Osoblje', style: AppTextStyles.heading3),
              const SizedBox(height: 10),
              _buildInfoCard([
                _InfoRow(
                  label: 'Ime i prezime',
                  value: appointment.staffFullName,
                ),
                _InfoRow(
                  label: 'Tip',
                  value: _typeLabel(appointment.staffType),
                ),
              ]),
              const SizedBox(height: 20),

              // Appointment info
              Text('Informacije', style: AppTextStyles.heading3),
              const SizedBox(height: 10),
              _buildInfoCard([
                _InfoRow(
                  label: 'Datum i vrijeme',
                  value: _formatDateTime(appointment.scheduledAt),
                ),
                _InfoRow(
                  label: 'Trajanje',
                  value: '${appointment.durationMinutes} minuta',
                ),
                _InfoRow(
                  label: 'Kreirano',
                  value: _formatDateTime(appointment.createdAt),
                ),
              ]),

              // Notes
              if (appointment.notes != null &&
                  appointment.notes!.isNotEmpty) ...[
                const SizedBox(height: 20),
                Text('Napomena', style: AppTextStyles.heading3),
                const SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Text(
                    appointment.notes!,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                      height: 1.5,
                    ),
                  ),
                ),
              ],

              // Cancel button
              if (canCancel) ...[
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: isCancelling
                        ? null
                        : () => _confirmCancel(context, ref, appointment.id),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.error.withValues(alpha: 0.15),
                      foregroundColor: AppColors.error,
                      disabledBackgroundColor:
                          AppColors.error.withValues(alpha: 0.08),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 0,
                    ),
                    child: isCancelling
                        ? const SizedBox(
                            width: 22,
                            height: 22,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.5,
                              color: AppColors.error,
                            ),
                          )
                        : Text(
                            'Otkaži termin',
                            style: AppTextStyles.button.copyWith(
                              color: AppColors.error,
                            ),
                          ),
                  ),
                ),
              ],
            ],
          );
        },
      ),
    );
  }

  Widget _buildStatusSection(AppointmentModel appointment) {
    if (appointment.status == 'Cancelled') {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.error.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.error.withValues(alpha: 0.3)),
        ),
        child: Row(
          children: [
            const Icon(Icons.cancel_outlined, color: AppColors.error),
            const SizedBox(width: 12),
            Text(
              'Termin je otkazan',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.error,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      );
    }

    if (appointment.status == 'Completed') {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.success.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.success.withValues(alpha: 0.3)),
        ),
        child: Row(
          children: [
            const Icon(Icons.check_circle_outlined, color: AppColors.success),
            const SizedBox(width: 12),
            Text(
              'Termin je završen',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.success,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Status',
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          AppointmentStatusBadge(status: appointment.status),
        ],
      ),
    );
  }

  Widget _buildInfoCard(List<_InfoRow> rows) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          for (int i = 0; i < rows.length; i++) ...[
            rows[i],
            if (i < rows.length - 1) const SizedBox(height: 10),
          ],
        ],
      ),
    );
  }

  void _confirmCancel(BuildContext context, WidgetRef ref, int id) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.surface,
        title: Text(
          'Otkaži termin?',
          style: AppTextStyles.heading3,
        ),
        content: Text(
          'Da li ste sigurni da želite otkazati ovaj termin?',
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text(
              'Ne',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              ref.read(cancelAppointmentProvider.notifier).cancel(id);
            },
            child: Text(
              'Da, otkaži',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.error,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _typeLabel(String staffType) {
    return switch (staffType) {
      'Trainer' => 'Trener',
      'Nutritionist' => 'Nutricionist',
      _ => staffType,
    };
  }

  String _formatDateTime(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year}. '
        '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(width: 12),
        Flexible(
          child: Text(
            value,
            style: AppTextStyles.bodyMedium.copyWith(
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }
}
