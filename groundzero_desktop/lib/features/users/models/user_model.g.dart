// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserModelImpl _$$UserModelImplFromJson(Map<String, dynamic> json) =>
    _$UserModelImpl(
      id: (json['id'] as num).toInt(),
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      email: json['email'] as String,
      profileImageUrl: json['profileImageUrl'] as String?,
      role: json['role'] as String,
      level: (json['level'] as num).toInt(),
      xp: (json['xp'] as num).toInt(),
      totalGymMinutes: (json['totalGymMinutes'] as num).toInt(),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'profileImageUrl': instance.profileImageUrl,
      'role': instance.role,
      'level': instance.level,
      'xp': instance.xp,
      'totalGymMinutes': instance.totalGymMinutes,
      'createdAt': instance.createdAt.toIso8601String(),
    };
