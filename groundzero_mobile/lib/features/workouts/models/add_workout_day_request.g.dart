// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_workout_day_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AddWorkoutDayRequestImpl _$$AddWorkoutDayRequestImplFromJson(
  Map<String, dynamic> json,
) => _$AddWorkoutDayRequestImpl(
  dayOfWeek: (json['dayOfWeek'] as num).toInt(),
  name: json['name'] as String,
);

Map<String, dynamic> _$$AddWorkoutDayRequestImplToJson(
  _$AddWorkoutDayRequestImpl instance,
) => <String, dynamic>{'dayOfWeek': instance.dayOfWeek, 'name': instance.name};
