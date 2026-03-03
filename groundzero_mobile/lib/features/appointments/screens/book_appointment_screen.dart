import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../shared/widgets/error_display.dart';
import '../../../shared/widgets/primary_button.dart';
import '../providers/appointment_provider.dart';
import '../providers/staff_provider.dart';

class BookAppointmentScreen extends ConsumerStatefulWidget {
  final int staffId;

  const BookAppointmentScreen({super.key, required this.staffId});

  @override
  ConsumerState<BookAppointmentScreen> createState() =>
      _BookAppointmentScreenState();
}

class _BookAppointmentScreenState
    extends ConsumerState<BookAppointmentScreen> {
  DateTime _selectedDate = DateTime.now().add(const Duration(days: 1));
  String? _selectedTime;
  int _selectedDuration = 60;
  final _notesController = TextEditingController();

  static const _durations = [30, 45, 60, 90];

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  DateTime _buildScheduledAt() {
    final parts = _selectedTime!.split(':');
    return DateTime.utc(
      _selectedDate.year,
      _selectedDate.month,
      _selectedDate.day,
      int.parse(parts[0]),
      int.parse(parts[1]),
    );
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: now,
      lastDate: now.add(const Duration(days: 90)),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.dark(
            primary: AppColors.accent,
            onPrimary: AppColors.onAccent,
            surface: AppColors.surface,
            onSurface: AppColors.textPrimary,
          ),
        ),
        child: child!,
      ),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        _selectedTime = null;
      });
    }
  }

  void _submit() {
    if (_selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Odaberite vrijeme termina.',
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    final scheduledAt = _buildScheduledAt();
    if (scheduledAt.isBefore(DateTime.now().toUtc())) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Termin mora biti u budućnosti.',
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    ref.read(createAppointmentProvider.notifier).book(
          staffId: widget.staffId,
          scheduledAt: scheduledAt,
          durationMinutes: _selectedDuration,
          notes: _notesController.text.isNotEmpty
              ? _notesController.text
              : null,
        );
  }

  @override
  Widget build(BuildContext context) {
    final staffAsync = ref.watch(staffDetailProvider(widget.staffId));
    final createState = ref.watch(createAppointmentProvider);
    final slotsAsync = ref.watch(availableSlotsProvider(
      (staffId: widget.staffId, date: _selectedDate),
    ));

    ref.listen(createAppointmentProvider, (prev, next) {
      if (next is CreateAppointmentSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Termin je uspješno zakazan!',
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
            backgroundColor: AppColors.success,
          ),
        );
        ref.read(createAppointmentProvider.notifier).reset();
        if (context.mounted) context.pop();
      } else if (next is CreateAppointmentError) {
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
        ref.read(createAppointmentProvider.notifier).reset();
      }
    });

    final isLoading = createState is CreateAppointmentLoading;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Zakaži termin', style: AppTextStyles.heading3),
      ),
      body: staffAsync.when(
        loading: () => const Center(
          child: CircularProgressIndicator(color: AppColors.accent),
        ),
        error: (_, _) => ErrorDisplay(
          message: 'Greška pri učitavanju.',
          onRetry: () =>
              ref.invalidate(staffDetailProvider(widget.staffId)),
        ),
        data: (staff) {
          final staffName = '${staff.firstName} ${staff.lastName}';
          final typeLabel = staff.staffType == 'Trainer'
              ? 'Trener'
              : staff.staffType == 'Nutritionist'
                  ? 'Nutricionist'
                  : staff.staffType;

          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              // Staff info
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.border),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.person_outline_rounded,
                      color: AppColors.accent,
                      size: 28,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            staffName,
                            style: AppTextStyles.bodyMedium.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            typeLabel,
                            style: AppTextStyles.bodySmall.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Date picker
              Text('Datum', style: AppTextStyles.inputLabel),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: _pickDate,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.inputFill,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.calendar_today_rounded,
                        color: AppColors.textHint,
                        size: 20,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        _formatDate(_selectedDate),
                        style: AppTextStyles.input,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Available time slots from API
              Text('Slobodni termini', style: AppTextStyles.inputLabel),
              const SizedBox(height: 8),
              slotsAsync.when(
                loading: () => const SizedBox(
                  height: 80,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: AppColors.accent,
                      strokeWidth: 2,
                    ),
                  ),
                ),
                error: (_, _) => Text(
                  'Greška pri učitavanju slobodnih termina.',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.error,
                  ),
                ),
                data: (slots) {
                  final hasAvailable = slots.any((s) => s.isAvailable);
                  if (!hasAvailable) {
                    return Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Text(
                        'Nema slobodnih termina za ovaj datum.',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.textSecondary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    );
                  }

                  return Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: slots.map((slot) {
                      final isSelected = _selectedTime == slot.time;
                      final isAvailable = slot.isAvailable;

                      return GestureDetector(
                        onTap: isAvailable
                            ? () => setState(
                                () => _selectedTime = slot.time)
                            : null,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.accent
                                : isAvailable
                                    ? AppColors.inputFill
                                    : AppColors.surface,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: isSelected
                                  ? AppColors.accent
                                  : isAvailable
                                      ? AppColors.border
                                      : AppColors.border
                                          .withValues(alpha: 0.3),
                            ),
                          ),
                          child: Text(
                            slot.time,
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: isSelected
                                  ? AppColors.onAccent
                                  : isAvailable
                                      ? AppColors.textPrimary
                                      : AppColors.textHint
                                          .withValues(alpha: 0.5),
                              fontWeight: isSelected
                                  ? FontWeight.w600
                                  : FontWeight.w400,
                              decoration: isAvailable
                                  ? null
                                  : TextDecoration.lineThrough,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
              const SizedBox(height: 20),

              // Duration
              Text('Trajanje', style: AppTextStyles.inputLabel),
              const SizedBox(height: 8),
              Wrap(
                spacing: 10,
                children: _durations.map((d) {
                  final isSelected = _selectedDuration == d;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedDuration = d),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.accent
                            : AppColors.inputFill,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: isSelected
                              ? AppColors.accent
                              : AppColors.border,
                        ),
                      ),
                      child: Text(
                        '$d min',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: isSelected
                              ? AppColors.onAccent
                              : AppColors.textPrimary,
                          fontWeight: isSelected
                              ? FontWeight.w600
                              : FontWeight.w400,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),

              // Notes
              Text('Napomena (opcionalno)', style: AppTextStyles.inputLabel),
              const SizedBox(height: 8),
              TextField(
                controller: _notesController,
                style: AppTextStyles.input,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: 'Unesite napomenu...',
                  hintStyle: AppTextStyles.inputHint,
                  filled: true,
                  fillColor: AppColors.inputFill,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.all(16),
                ),
              ),
              const SizedBox(height: 32),

              // Submit button
              PrimaryButton(
                label: 'Potvrdi termin',
                isLoading: isLoading,
                onPressed: isLoading ? null : _submit,
              ),
            ],
          );
        },
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year}.';
  }
}
