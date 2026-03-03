import 'package:freezed_annotation/freezed_annotation.dart';

part 'workout_exercise_model.freezed.dart';
part 'workout_exercise_model.g.dart';

@freezed
class WorkoutExerciseModel with _$WorkoutExerciseModel {
  const factory WorkoutExerciseModel({
    required int id,
    required int exerciseId,
    required String exerciseName,
    required int muscleGroup,
    required int sets,
    required int reps,
    double? weight,
    int? restSeconds,
    required int orderIndex,
  }) = _WorkoutExerciseModel;

  factory WorkoutExerciseModel.fromJson(Map<String, dynamic> json) =>
      _$WorkoutExerciseModelFromJson(json);
}
