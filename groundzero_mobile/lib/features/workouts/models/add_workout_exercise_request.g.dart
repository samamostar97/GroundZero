// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_workout_exercise_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AddWorkoutExerciseRequestImpl _$$AddWorkoutExerciseRequestImplFromJson(
  Map<String, dynamic> json,
) => _$AddWorkoutExerciseRequestImpl(
  exerciseId: (json['exerciseId'] as num).toInt(),
  sets: (json['sets'] as num).toInt(),
  reps: (json['reps'] as num).toInt(),
  weight: (json['weight'] as num?)?.toDouble(),
  restSeconds: (json['restSeconds'] as num?)?.toInt(),
  orderIndex: (json['orderIndex'] as num).toInt(),
);

Map<String, dynamic> _$$AddWorkoutExerciseRequestImplToJson(
  _$AddWorkoutExerciseRequestImpl instance,
) => <String, dynamic>{
  'exerciseId': instance.exerciseId,
  'sets': instance.sets,
  'reps': instance.reps,
  'weight': instance.weight,
  'restSeconds': instance.restSeconds,
  'orderIndex': instance.orderIndex,
};
