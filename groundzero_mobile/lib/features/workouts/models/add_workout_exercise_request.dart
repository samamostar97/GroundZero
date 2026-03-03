import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_workout_exercise_request.freezed.dart';
part 'add_workout_exercise_request.g.dart';

@freezed
class AddWorkoutExerciseRequest with _$AddWorkoutExerciseRequest {
  const factory AddWorkoutExerciseRequest({
    required int exerciseId,
    required int sets,
    required int reps,
    double? weight,
    int? restSeconds,
    required int orderIndex,
  }) = _AddWorkoutExerciseRequest;

  factory AddWorkoutExerciseRequest.fromJson(Map<String, dynamic> json) =>
      _$AddWorkoutExerciseRequestFromJson(json);
}
