import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_shadows.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/network/api_exception.dart';
import '../../../shared/widgets/error_display.dart';
import '../../../shared/widgets/skeletons.dart';
import '../data/workout_repository.dart';
import '../models/add_workout_day_request.dart';
import '../models/add_workout_exercise_request.dart';
import '../models/exercise_model.dart';
import '../models/workout_day_model.dart';
import '../models/workout_exercise_model.dart';
import '../models/workout_plan_model.dart';
import '../providers/exercises_provider.dart';
import '../providers/workout_plan_detail_provider.dart';
import '../providers/workout_plans_provider.dart';

// Bosnian labels
const _dayOfWeekLabels = [
  'Nedjelja',
  'Ponedjeljak',
  'Utorak',
  'Srijeda',
  'Četvrtak',
  'Petak',
  'Subota',
];

const _muscleGroupLabels = [
  'Prsa',
  'Leđa',
  'Ramena',
  'Biceps',
  'Triceps',
  'Noge',
  'Core',
  'Kardio',
  'Cijelo tijelo',
];

class WorkoutPlanDetailScreen extends ConsumerWidget {
  final int planId;

  const WorkoutPlanDetailScreen({super.key, required this.planId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final planAsync = ref.watch(workoutPlanDetailProvider(planId));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: planAsync.whenOrNull(
          data: (plan) => Text(plan.name, style: AppTextStyles.heading3),
        ),
        actions: [
          planAsync.whenOrNull(
                data: (plan) => PopupMenuButton<String>(
                  color: AppColors.surface,
                  icon: const Icon(Icons.more_vert_rounded),
                  onSelected: (value) {
                    if (value == 'delete') {
                      _confirmDeletePlan(context, ref, plan);
                    }
                  },
                  itemBuilder: (_) => [
                    PopupMenuItem(
                      value: 'delete',
                      child: Text(
                        'Obriši plan',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.error,
                        ),
                      ),
                    ),
                  ],
                ),
              ) ??
              const SizedBox.shrink(),
        ],
      ),
      body: planAsync.when(
        loading: () => const WorkoutPlanDetailSkeleton(),
        error: (error, _) => ErrorDisplay(
          message: 'Greška pri učitavanju plana.',
          onRetry: () => ref.invalidate(workoutPlanDetailProvider(planId)),
        ),
        data: (plan) => _PlanDetailBody(plan: plan, planId: planId),
      ),
    );
  }

  void _confirmDeletePlan(
      BuildContext context, WidgetRef ref, WorkoutPlanModel plan) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.surfaceHigh,
        title: Text('Obriši plan?', style: AppTextStyles.heading3),
        content: Text(
          'Da li ste sigurni da želite obrisati "${plan.name}"?',
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
            onPressed: () async {
              Navigator.of(ctx).pop();
              final notifier =
                  ref.read(deleteWorkoutPlanProvider.notifier);
              await notifier.delete(planId);

              final state = ref.read(deleteWorkoutPlanProvider);
              if (state is DeleteWorkoutPlanSuccess && context.mounted) {
                notifier.reset();
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Plan treninga uspješno obrisan.'),
                    backgroundColor: AppColors.success,
                  ),
                );
              } else if (state is DeleteWorkoutPlanError && context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: AppColors.error,
                  ),
                );
              }
            },
            child: Text(
              'Da, obriši',
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
}

class _PlanDetailBody extends ConsumerWidget {
  final WorkoutPlanModel plan;
  final int planId;

  const _PlanDetailBody({required this.plan, required this.planId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        // Plan description
        if (plan.description != null && plan.description!.isNotEmpty) ...[
          Text(
            plan.description!,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 16),
        ],

        // Days
        if (plan.days.isEmpty)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 24),
            child: Center(
              child: Text(
                'Nema dodanih dana. Dodajte prvi dan!',
                style: TextStyle(color: AppColors.textHint),
              ),
            ),
          )
        else
          ...plan.days.map(
            (day) => _DayCard(
              day: day,
              planId: planId,
            ),
          ),

        const SizedBox(height: 16),

        // Add day button
        OutlinedButton.icon(
          onPressed: plan.days.length >= 7
              ? null
              : () => _showAddDaySheet(context, ref,
                    usedDays: plan.days.map((d) => d.dayOfWeek).toSet()),
          icon: const Icon(Icons.add_rounded, size: 20),
          label: const Text('Dodaj dan'),
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.accent,
            side: const BorderSide(color: AppColors.accent),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(vertical: 14),
          ),
        ),
      ],
    );
  }

  void _showAddDaySheet(BuildContext context, WidgetRef ref,
      {required Set<int> usedDays}) {
    final nameController = TextEditingController();
    // Default to first available day (prefer Monday=1 first, then cycle)
    int selectedDayOfWeek = [1, 2, 3, 4, 5, 6, 0]
        .firstWhere((d) => !usedDays.contains(d), orElse: () => 1);
    bool isSubmitting = false;
    String? errorMessage;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.surfaceHigh,
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
              Text('Dodaj dan', style: AppTextStyles.heading3),
              const SizedBox(height: 16),

              // Day of week picker
              Text('Dan u sedmici', style: AppTextStyles.inputLabel),
              const SizedBox(height: 8),
              SizedBox(
                height: 38,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: 7,
                  separatorBuilder: (_, _) => const SizedBox(width: 6),
                  itemBuilder: (_, i) {
                    final isSelected = selectedDayOfWeek == i;
                    final isUsed = usedDays.contains(i);
                    return GestureDetector(
                      onTap: isUsed
                          ? null
                          : () =>
                              setSheetState(() => selectedDayOfWeek = i),
                      child: Opacity(
                        opacity: isUsed ? 0.3 : 1.0,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.accent
                                : AppColors.inputFill,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            _dayOfWeekLabels[i].substring(0, 3),
                            style: AppTextStyles.bodySmall.copyWith(
                              color: isSelected
                                  ? AppColors.onAccent
                                  : AppColors.textPrimary,
                              fontWeight: isSelected
                                  ? FontWeight.w600
                                  : FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 14),

              // Name
              TextField(
                controller: nameController,
                style: AppTextStyles.input,
                decoration: InputDecoration(
                  hintText: 'Naziv dana (npr. Push dan)',
                  hintStyle: AppTextStyles.inputHint,
                  filled: true,
                  fillColor: AppColors.inputFill,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
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
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: isSubmitting
                      ? null
                      : () async {
                          final name = nameController.text.trim();
                          if (name.isEmpty) {
                            setSheetState(() {
                              errorMessage = 'Naziv dana je obavezan.';
                            });
                            return;
                          }

                          setSheetState(() {
                            isSubmitting = true;
                            errorMessage = null;
                          });

                          try {
                            final repo =
                                ref.read(workoutRepositoryProvider);
                            await repo.addDay(
                              planId,
                              AddWorkoutDayRequest(
                                dayOfWeek: selectedDayOfWeek,
                                name: name,
                              ),
                            );
                            ref.invalidate(
                                workoutPlanDetailProvider(planId));
                            if (context.mounted) {
                              Navigator.of(context).pop();
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
                      : Text('Dodaj', style: AppTextStyles.button),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// --- Day card with expandable exercises ---

class _DayCard extends ConsumerStatefulWidget {
  final WorkoutDayModel day;
  final int planId;

  const _DayCard({required this.day, required this.planId});

  @override
  ConsumerState<_DayCard> createState() => _DayCardState();
}

class _DayCardState extends ConsumerState<_DayCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final day = widget.day;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: AppShadows.card,
      ),
      child: Column(
        children: [
          // Header — tap to expand
          InkWell(
            onTap: () => setState(() => _expanded = !_expanded),
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          day.name,
                          style: AppTextStyles.bodyMedium.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          _dayOfWeekLabels[day.dayOfWeek],
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.textHint,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    '${day.exercises.length} vj.',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.accent,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Icon(
                    _expanded
                        ? Icons.expand_less_rounded
                        : Icons.expand_more_rounded,
                    color: AppColors.textHint,
                  ),
                ],
              ),
            ),
          ),

          // Expanded content
          if (_expanded) ...[
            const Divider(height: 1, color: AppColors.border),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  // Exercises
                  if (day.exercises.isEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Text(
                        'Nema vježbi. Dodajte prvu!',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.textHint,
                        ),
                      ),
                    )
                  else
                    ...day.exercises.map(
                      (ex) => _ExerciseTile(
                        exercise: ex,
                        planId: widget.planId,
                        dayId: day.id,
                      ),
                    ),

                  const SizedBox(height: 8),

                  // Action row
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () => _showAddExerciseSheet(
                              context, ref, widget.planId, day.id,
                              existingCount: day.exercises.length),
                          icon: const Icon(Icons.add_rounded, size: 18),
                          label: const Text('Vježba'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppColors.accent,
                            side: const BorderSide(color: AppColors.accent),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 10),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      // Delete day
                      IconButton(
                        onPressed: () =>
                            _confirmDeleteDay(context, ref, day),
                        icon: const Icon(Icons.delete_outline_rounded,
                            size: 20),
                        color: AppColors.error,
                        tooltip: 'Obriši dan',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  void _confirmDeleteDay(
      BuildContext context, WidgetRef ref, WorkoutDayModel day) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.surfaceHigh,
        title: Text('Obriši dan?', style: AppTextStyles.heading3),
        content: Text(
          'Da li ste sigurni da želite obrisati "${day.name}"?',
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
            onPressed: () async {
              Navigator.of(ctx).pop();
              try {
                final repo = ref.read(workoutRepositoryProvider);
                await repo.removeDay(widget.planId, day.id);
                ref.invalidate(
                    workoutPlanDetailProvider(widget.planId));
              } on ApiException catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(e.firstError),
                      backgroundColor: AppColors.error,
                    ),
                  );
                }
              } catch (_) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content:
                          Text('Neočekivana greška. Pokušajte ponovo.'),
                      backgroundColor: AppColors.error,
                    ),
                  );
                }
              }
            },
            child: Text(
              'Da, obriši',
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
}

// --- Exercise tile ---

class _ExerciseTile extends ConsumerWidget {
  final WorkoutExerciseModel exercise;
  final int planId;
  final int dayId;

  const _ExerciseTile({
    required this.exercise,
    required this.planId,
    required this.dayId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final muscleLabel = exercise.muscleGroup >= 0 &&
            exercise.muscleGroup < _muscleGroupLabels.length
        ? _muscleGroupLabels[exercise.muscleGroup]
        : '';

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.inputFill,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  exercise.exerciseName,
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  _buildDetail(muscleLabel),
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textHint,
                  ),
                ),
              ],
            ),
          ),
          // Edit
          IconButton(
            onPressed: () => _showEditExerciseSheet(context, ref),
            icon: const Icon(Icons.edit_outlined, size: 18),
            color: AppColors.textSecondary,
            constraints: const BoxConstraints(),
            padding: const EdgeInsets.all(6),
          ),
          // Delete
          IconButton(
            onPressed: () => _confirmDeleteExercise(context, ref),
            icon: const Icon(Icons.close_rounded, size: 18),
            color: AppColors.error,
            constraints: const BoxConstraints(),
            padding: const EdgeInsets.all(6),
          ),
        ],
      ),
    );
  }

  String _buildDetail(String muscleLabel) {
    final parts = <String>[
      muscleLabel,
      '${exercise.sets}x${exercise.reps}',
    ];
    if (exercise.weight != null) {
      parts.add('${exercise.weight!.toStringAsFixed(1)} kg');
    }
    if (exercise.restSeconds != null) {
      parts.add('${exercise.restSeconds}s odmor');
    }
    return parts.join(' · ');
  }

  void _showEditExerciseSheet(BuildContext context, WidgetRef ref) {
    final setsController =
        TextEditingController(text: exercise.sets.toString());
    final repsController =
        TextEditingController(text: exercise.reps.toString());
    final weightController = TextEditingController(
        text: exercise.weight?.toStringAsFixed(1) ?? '');
    final restController = TextEditingController(
        text: exercise.restSeconds?.toString() ?? '');
    bool isSubmitting = false;
    String? errorMessage;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.surfaceHigh,
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
              Text(
                'Uredi: ${exercise.exerciseName}',
                style: AppTextStyles.heading3,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _NumberField(
                      controller: setsController,
                      label: 'Serije',
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _NumberField(
                      controller: repsController,
                      label: 'Ponavljanja',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _NumberField(
                      controller: weightController,
                      label: 'Težina (kg)',
                      decimal: true,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _NumberField(
                      controller: restController,
                      label: 'Odmor (sek)',
                    ),
                  ),
                ],
              ),
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
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: isSubmitting
                      ? null
                      : () async {
                          final sets =
                              int.tryParse(setsController.text.trim());
                          final reps =
                              int.tryParse(repsController.text.trim());
                          if (sets == null || reps == null) {
                            setSheetState(() {
                              errorMessage =
                                  'Serije i ponavljanja su obavezni.';
                            });
                            return;
                          }

                          setSheetState(() {
                            isSubmitting = true;
                            errorMessage = null;
                          });

                          try {
                            final repo =
                                ref.read(workoutRepositoryProvider);
                            await repo.updateExercise(
                              planId,
                              dayId,
                              exercise.id,
                              sets: sets,
                              reps: reps,
                              weight: double.tryParse(
                                  weightController.text.trim()),
                              restSeconds:
                                  int.tryParse(restController.text.trim()),
                              orderIndex: exercise.orderIndex,
                            );
                            ref.invalidate(
                                workoutPlanDetailProvider(planId));
                            if (context.mounted) {
                              Navigator.of(context).pop();
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
                      : Text('Sačuvaj', style: AppTextStyles.button),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _confirmDeleteExercise(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.surfaceHigh,
        title: Text('Obriši vježbu?', style: AppTextStyles.heading3),
        content: Text(
          'Da li ste sigurni da želite ukloniti "${exercise.exerciseName}"?',
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
            onPressed: () async {
              Navigator.of(ctx).pop();
              try {
                final repo = ref.read(workoutRepositoryProvider);
                await repo.removeExercise(planId, dayId, exercise.id);
                ref.invalidate(workoutPlanDetailProvider(planId));
              } on ApiException catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(e.firstError),
                      backgroundColor: AppColors.error,
                    ),
                  );
                }
              } catch (_) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content:
                          Text('Neočekivana greška. Pokušajte ponovo.'),
                      backgroundColor: AppColors.error,
                    ),
                  );
                }
              }
            },
            child: Text(
              'Da, obriši',
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
}

// --- Add exercise bottom sheet ---

void _showAddExerciseSheet(
  BuildContext context,
  WidgetRef ref,
  int planId,
  int dayId, {
  required int existingCount,
}) {
  int? selectedMuscleGroup;
  ExerciseModel? selectedExercise;
  final setsController = TextEditingController(text: '3');
  final repsController = TextEditingController(text: '10');
  bool isSubmitting = false;
  String? errorMessage;

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: AppColors.surfaceHigh,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (sheetContext) => StatefulBuilder(
      builder: (sheetContext, setSheetState) {
        return Padding(
          padding: EdgeInsets.fromLTRB(
            20,
            20,
            20,
            20 + MediaQuery.of(sheetContext).viewInsets.bottom,
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(sheetContext).size.height * 0.8,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Dodaj vježbu', style: AppTextStyles.heading3),
                  const SizedBox(height: 14),

                  // Muscle group filter chips
                  Text('Grupa mišića', style: AppTextStyles.inputLabel),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: [
                      _FilterChip(
                        label: 'Sve',
                        isSelected: selectedMuscleGroup == null,
                        onTap: () => setSheetState(() {
                          selectedMuscleGroup = null;
                          selectedExercise = null;
                        }),
                      ),
                      for (int i = 0; i < _muscleGroupLabels.length; i++)
                        _FilterChip(
                          label: _muscleGroupLabels[i],
                          isSelected: selectedMuscleGroup == i,
                          onTap: () => setSheetState(() {
                            selectedMuscleGroup = i;
                            selectedExercise = null;
                          }),
                        ),
                    ],
                  ),
                  const SizedBox(height: 14),

                  // Exercise dropdown — wrapped in Consumer so it reacts to provider changes
                  Text('Vježba', style: AppTextStyles.inputLabel),
                  const SizedBox(height: 8),
                  Consumer(
                    builder: (_, consumerRef, _) {
                      final exercisesAsync = consumerRef
                          .watch(exercisesProvider(selectedMuscleGroup));
                      return exercisesAsync.when(
                        loading: () => const Center(
                          child: Padding(
                            padding: EdgeInsets.all(12),
                            child: CircularProgressIndicator(
                              color: AppColors.accent,
                              strokeWidth: 2,
                            ),
                          ),
                        ),
                        error: (_, _) => Text(
                          'Greška pri učitavanju vježbi.',
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.error,
                          ),
                        ),
                        data: (exercises) => Container(
                          padding:
                              const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            color: AppColors.inputFill,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: DropdownButton<int>(
                            value: selectedExercise?.id,
                            isExpanded: true,
                            dropdownColor: AppColors.surface,
                            underline: const SizedBox.shrink(),
                            hint: Text(
                              'Odaberi vježbu',
                              style: AppTextStyles.inputHint,
                            ),
                            style: AppTextStyles.input,
                            items: exercises
                                .map(
                                  (e) => DropdownMenuItem(
                                    value: e.id,
                                    child: Text(e.name),
                                  ),
                                )
                                .toList(),
                            onChanged: (id) {
                              if (id == null) return;
                              setSheetState(() {
                                selectedExercise = exercises
                                    .firstWhere((e) => e.id == id);
                              });
                            },
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 14),

                  // Sets / Reps
                  Row(
                    children: [
                      Expanded(
                        child: _NumberField(
                          controller: setsController,
                          label: 'Serije',
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _NumberField(
                          controller: repsController,
                          label: 'Ponavljanja',
                        ),
                      ),
                    ],
                  ),

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
                      onPressed: isSubmitting
                          ? null
                          : () async {
                              if (selectedExercise == null) {
                                setSheetState(() {
                                  errorMessage = 'Odaberite vježbu.';
                                });
                                return;
                              }
                              final sets =
                                  int.tryParse(setsController.text.trim());
                              final reps =
                                  int.tryParse(repsController.text.trim());
                              if (sets == null || reps == null) {
                                setSheetState(() {
                                  errorMessage =
                                      'Serije i ponavljanja su obavezni.';
                                });
                                return;
                              }

                              setSheetState(() {
                                isSubmitting = true;
                                errorMessage = null;
                              });

                              try {
                                final repo =
                                    ref.read(workoutRepositoryProvider);
                                await repo.addExercise(
                                  planId,
                                  dayId,
                                  AddWorkoutExerciseRequest(
                                    exerciseId: selectedExercise!.id,
                                    sets: sets,
                                    reps: reps,
                                    orderIndex: existingCount,
                                  ),
                                );
                                ref.invalidate(
                                    workoutPlanDetailProvider(planId));
                                if (sheetContext.mounted) {
                                  Navigator.of(sheetContext).pop();
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
                          : Text('Dodaj', style: AppTextStyles.button),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    ),
  );
}

// --- Helper widgets ---

class _NumberField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final bool decimal;

  const _NumberField({
    required this.controller,
    required this.label,
    this.decimal = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.inputLabel),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          keyboardType: TextInputType.numberWithOptions(decimal: decimal),
          style: AppTextStyles.input,
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.inputFill,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 12,
            ),
          ),
        ),
      ],
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.accent : AppColors.inputFill,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: AppTextStyles.bodySmall.copyWith(
            color: isSelected ? AppColors.onAccent : AppColors.textPrimary,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
      ),
    );
  }
}

