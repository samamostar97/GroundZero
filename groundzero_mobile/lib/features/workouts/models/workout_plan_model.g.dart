// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_plan_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WorkoutPlanModelImpl _$$WorkoutPlanModelImplFromJson(
  Map<String, dynamic> json,
) => _$WorkoutPlanModelImpl(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  description: json['description'] as String?,
  days:
      (json['days'] as List<dynamic>?)
          ?.map((e) => WorkoutDayModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  createdAt: DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$$WorkoutPlanModelImplToJson(
  _$WorkoutPlanModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'description': instance.description,
  'days': instance.days,
  'createdAt': instance.createdAt.toIso8601String(),
};
