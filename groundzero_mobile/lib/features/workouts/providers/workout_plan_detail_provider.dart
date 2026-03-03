import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/workout_repository.dart';
import '../models/workout_plan_model.dart';

final workoutPlanDetailProvider =
    FutureProvider.family<WorkoutPlanModel, int>((ref, planId) {
  final repo = ref.watch(workoutRepositoryProvider);
  return repo.getPlanById(planId);
});
