import 'package:freezed_annotation/freezed_annotation.dart';

import 'workout_exercise_model.dart';

part 'workout_day_model.freezed.dart';
part 'workout_day_model.g.dart';

@freezed
class WorkoutDayModel with _$WorkoutDayModel {
  const factory WorkoutDayModel({
    required int id,
    required int dayOfWeek,
    required String name,
    @Default([]) List<WorkoutExerciseModel> exercises,
  }) = _WorkoutDayModel;

  factory WorkoutDayModel.fromJson(Map<String, dynamic> json) =>
      _$WorkoutDayModelFromJson(json);
}
