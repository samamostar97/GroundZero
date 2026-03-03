import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_workout_day_request.freezed.dart';
part 'add_workout_day_request.g.dart';

@freezed
class AddWorkoutDayRequest with _$AddWorkoutDayRequest {
  const factory AddWorkoutDayRequest({
    required int dayOfWeek,
    required String name,
  }) = _AddWorkoutDayRequest;

  factory AddWorkoutDayRequest.fromJson(Map<String, dynamic> json) =>
      _$AddWorkoutDayRequestFromJson(json);
}
