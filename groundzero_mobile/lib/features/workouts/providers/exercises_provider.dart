import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/exercise_repository.dart';
import '../models/exercise_model.dart';

/// Family by muscleGroup: null = all exercises, int = filter by muscleGroup enum value
final exercisesProvider =
    FutureProvider.family<List<ExerciseModel>, int?>((ref, muscleGroup) {
  final repo = ref.watch(exerciseRepositoryProvider);
  return repo.getExercises(muscleGroup: muscleGroup);
});
