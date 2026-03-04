import 'package:freezed_annotation/freezed_annotation.dart';

part 'gym_visit_model.freezed.dart';
part 'gym_visit_model.g.dart';

@freezed
class GymVisitModel with _$GymVisitModel {
  const factory GymVisitModel({
    required int id,
    required int userId,
    required String userFullName,
    required DateTime checkInAt,
    DateTime? checkOutAt,
    int? durationMinutes,
    required int xpEarned,
    required DateTime createdAt,
  }) = _GymVisitModel;

  factory GymVisitModel.fromJson(Map<String, dynamic> json) =>
      _$GymVisitModelFromJson(json);
}
