// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gym_visit_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GymVisitModelImpl _$$GymVisitModelImplFromJson(Map<String, dynamic> json) =>
    _$GymVisitModelImpl(
      id: (json['id'] as num).toInt(),
      userId: (json['userId'] as num).toInt(),
      userFullName: json['userFullName'] as String,
      checkInAt: DateTime.parse(json['checkInAt'] as String),
      checkOutAt: json['checkOutAt'] == null
          ? null
          : DateTime.parse(json['checkOutAt'] as String),
      durationMinutes: (json['durationMinutes'] as num?)?.toInt(),
      xpEarned: (json['xpEarned'] as num).toInt(),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$GymVisitModelImplToJson(_$GymVisitModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'userFullName': instance.userFullName,
      'checkInAt': instance.checkInAt.toIso8601String(),
      'checkOutAt': instance.checkOutAt?.toIso8601String(),
      'durationMinutes': instance.durationMinutes,
      'xpEarned': instance.xpEarned,
      'createdAt': instance.createdAt.toIso8601String(),
    };
