// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_appointment_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CreateAppointmentRequestImpl _$$CreateAppointmentRequestImplFromJson(
  Map<String, dynamic> json,
) => _$CreateAppointmentRequestImpl(
  staffId: (json['staffId'] as num).toInt(),
  scheduledAt: DateTime.parse(json['scheduledAt'] as String),
  durationMinutes: (json['durationMinutes'] as num).toInt(),
  notes: json['notes'] as String?,
);

Map<String, dynamic> _$$CreateAppointmentRequestImplToJson(
  _$CreateAppointmentRequestImpl instance,
) => <String, dynamic>{
  'staffId': instance.staffId,
  'scheduledAt': instance.scheduledAt.toIso8601String(),
  'durationMinutes': instance.durationMinutes,
  'notes': instance.notes,
};
