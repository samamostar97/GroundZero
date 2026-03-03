import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_workout_plan_request.freezed.dart';
part 'create_workout_plan_request.g.dart';

@freezed
class CreateWorkoutPlanRequest with _$CreateWorkoutPlanRequest {
  const factory CreateWorkoutPlanRequest({
    required String name,
    String? description,
  }) = _CreateWorkoutPlanRequest;

  factory CreateWorkoutPlanRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateWorkoutPlanRequestFromJson(json);
}
