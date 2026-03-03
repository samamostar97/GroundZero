import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_appointment_request.freezed.dart';
part 'create_appointment_request.g.dart';

@freezed
class CreateAppointmentRequest with _$CreateAppointmentRequest {
  const factory CreateAppointmentRequest({
    required int staffId,
    required DateTime scheduledAt,
    required int durationMinutes,
    String? notes,
  }) = _CreateAppointmentRequest;

  factory CreateAppointmentRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateAppointmentRequestFromJson(json);
}
