import 'package:freezed_annotation/freezed_annotation.dart';

import 'workout_day_model.dart';

part 'workout_plan_model.freezed.dart';
part 'workout_plan_model.g.dart';

@freezed
class WorkoutPlanModel with _$WorkoutPlanModel {
  const factory WorkoutPlanModel({
    required int id,
    required String name,
    String? description,
    @Default([]) List<WorkoutDayModel> days,
    required DateTime createdAt,
  }) = _WorkoutPlanModel;

  factory WorkoutPlanModel.fromJson(Map<String, dynamic> json) =>
      _$WorkoutPlanModelFromJson(json);
}
