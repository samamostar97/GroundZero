import 'package:freezed_annotation/freezed_annotation.dart';

part 'exercise_model.freezed.dart';
part 'exercise_model.g.dart';

@freezed
class ExerciseModel with _$ExerciseModel {
  const factory ExerciseModel({
    required int id,
    required String name,
    required int muscleGroup,
    String? description,
  }) = _ExerciseModel;

  factory ExerciseModel.fromJson(Map<String, dynamic> json) =>
      _$ExerciseModelFromJson(json);
}
