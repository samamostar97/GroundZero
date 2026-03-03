import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/network/api_exception.dart';
import '../../../shared/widgets/appointment_status_badge.dart';
import '../../../shared/widgets/error_display.dart';
import '../../../shared/widgets/rating_stars.dart';
import '../../../shared/widgets/skeletons.dart';
import '../../shop/data/review_repository.dart';
import '../../shop/models/create_review_request.dart';
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
        loading: () => const AppointmentDetailSkeleton(),
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

              // Review button for completed appointments
              if (appointment.status == 'Completed') ...[
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton.icon(
                    onPressed: () =>
                        _showReviewSheet(context, ref, appointment.id),
                    icon: const Icon(Icons.rate_review_outlined),
                    label: Text(
                      'Ostavi recenziju',
                      style: AppTextStyles.button,
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.accent,
                      foregroundColor: AppColors.onAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
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

  void _showReviewSheet(
      BuildContext context, WidgetRef ref, int appointmentId) {
    int selectedRating = 0;
    final commentController = TextEditingController();
    bool isSubmitting = false;
    String? errorMessage;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => StatefulBuilder(
        builder: (context, setSheetState) => Padding(
          padding: EdgeInsets.fromLTRB(
            20,
            20,
            20,
            20 + MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Ostavi recenziju', style: AppTextStyles.heading3),
              const SizedBox(height: 16),

              // Stars
              Center(
                child: RatingStars(
                  rating: selectedRating.toDouble(),
                  size: 36,
                  interactive: true,
                  onRatingChanged: (rating) {
                    setSheetState(() => selectedRating = rating);
                  },
                ),
              ),
              const SizedBox(height: 16),

              // Comment
              TextField(
                controller: commentController,
                maxLines: 3,
                style: AppTextStyles.input,
                decoration: InputDecoration(
                  hintText: 'Komentar (opcionalno)',
                  hintStyle: AppTextStyles.inputHint,
                  filled: true,
                  fillColor: AppColors.inputFill,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              // Error message
              if (errorMessage != null) ...[
                const SizedBox(height: 12),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.error.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    errorMessage!,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.error,
                    ),
                  ),
                ),
              ],
              const SizedBox(height: 16),

              // Submit
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: selectedRating == 0 || isSubmitting
                      ? null
                      : () async {
                          setSheetState(() => isSubmitting = true);
                          try {
                            final repo = ref.read(reviewRepositoryProvider);
                            await repo.createReview(
                              CreateReviewRequest(
                                rating: selectedRating,
                                comment: commentController.text.isNotEmpty
                                    ? commentController.text
                                    : null,
                                reviewType: 1, // Appointment
                                appointmentId: appointmentId,
                              ),
                            );
                            if (context.mounted) {
                              Navigator.of(context).pop();
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content:
                                      Text('Recenzija uspješno dodana!'),
                                  backgroundColor: AppColors.success,
                                ),
                              );
                            }
                          } on ApiException catch (e) {
                            setSheetState(() {
                              isSubmitting = false;
                              errorMessage = e.firstError;
                            });
                          } catch (_) {
                            setSheetState(() {
                              isSubmitting = false;
                              errorMessage =
                                  'Neočekivana greška. Pokušajte ponovo.';
                            });
                          }
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.accent,
                    foregroundColor: AppColors.onAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: isSubmitting
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: AppColors.onAccent,
                          ),
                        )
                      : Text('Pošalji', style: AppTextStyles.button),
                ),
              ),
            ],
          ),
        ),
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
