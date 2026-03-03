// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_exercise_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WorkoutExerciseModelImpl _$$WorkoutExerciseModelImplFromJson(
  Map<String, dynamic> json,
) => _$WorkoutExerciseModelImpl(
  id: (json['id'] as num).toInt(),
  exerciseId: (json['exerciseId'] as num).toInt(),
  exerciseName: json['exerciseName'] as String,
  muscleGroup: (json['muscleGroup'] as num).toInt(),
  sets: (json['sets'] as num).toInt(),
  reps: (json['reps'] as num).toInt(),
  weight: (json['weight'] as num?)?.toDouble(),
  restSeconds: (json['restSeconds'] as num?)?.toInt(),
  orderIndex: (json['orderIndex'] as num).toInt(),
);

Map<String, dynamic> _$$WorkoutExerciseModelImplToJson(
  _$WorkoutExerciseModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'exerciseId': instance.exerciseId,
  'exerciseName': instance.exerciseName,
  'muscleGroup': instance.muscleGroup,
  'sets': instance.sets,
  'reps': instance.reps,
  'weight': instance.weight,
  'restSeconds': instance.restSeconds,
  'orderIndex': instance.orderIndex,
};
