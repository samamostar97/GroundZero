// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ExerciseModelImpl _$$ExerciseModelImplFromJson(Map<String, dynamic> json) =>
    _$ExerciseModelImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      muscleGroup: (json['muscleGroup'] as num).toInt(),
      description: json['description'] as String?,
    );

Map<String, dynamic> _$$ExerciseModelImplToJson(_$ExerciseModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'muscleGroup': instance.muscleGroup,
      'description': instance.description,
    };
