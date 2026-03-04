// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppointmentModelImpl _$$AppointmentModelImplFromJson(
  Map<String, dynamic> json,
) => _$AppointmentModelImpl(
  id: (json['id'] as num).toInt(),
  userId: (json['userId'] as num).toInt(),
  userFullName: json['userFullName'] as String,
  staffId: (json['staffId'] as num).toInt(),
  staffFullName: json['staffFullName'] as String,
  staffType: json['staffType'] as String,
  scheduledAt: DateTime.parse(json['scheduledAt'] as String),
  durationMinutes: (json['durationMinutes'] as num).toInt(),
  status: json['status'] as String,
  notes: json['notes'] as String?,
  createdAt: DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$$AppointmentModelImplToJson(
  _$AppointmentModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'userId': instance.userId,
  'userFullName': instance.userFullName,
  'staffId': instance.staffId,
  'staffFullName': instance.staffFullName,
  'staffType': instance.staffType,
  'scheduledAt': instance.scheduledAt.toIso8601String(),
  'durationMinutes': instance.durationMinutes,
  'status': instance.status,
  'notes': instance.notes,
  'createdAt': instance.createdAt.toIso8601String(),
};
