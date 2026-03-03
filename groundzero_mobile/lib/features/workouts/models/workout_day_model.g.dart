// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_day_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WorkoutDayModelImpl _$$WorkoutDayModelImplFromJson(
  Map<String, dynamic> json,
) => _$WorkoutDayModelImpl(
  id: (json['id'] as num).toInt(),
  dayOfWeek: (json['dayOfWeek'] as num).toInt(),
  name: json['name'] as String,
  exercises:
      (json['exercises'] as List<dynamic>?)
          ?.map((e) => WorkoutExerciseModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$$WorkoutDayModelImplToJson(
  _$WorkoutDayModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'dayOfWeek': instance.dayOfWeek,
  'name': instance.name,
  'exercises': instance.exercises,
};
