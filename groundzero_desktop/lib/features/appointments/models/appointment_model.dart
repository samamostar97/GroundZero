import 'package:freezed_annotation/freezed_annotation.dart';

part 'appointment_model.freezed.dart';
part 'appointment_model.g.dart';

@freezed
class AppointmentModel with _$AppointmentModel {
  const factory AppointmentModel({
    required int id,
    required int userId,
    required String userFullName,
    required int staffId,
    required String staffFullName,
    required String staffType,
    required DateTime scheduledAt,
    required int durationMinutes,
    required String status,
    String? notes,
    required DateTime createdAt,
  }) = _AppointmentModel;

  factory AppointmentModel.fromJson(Map<String, dynamic> json) =>
      _$AppointmentModelFromJson(json);
}
