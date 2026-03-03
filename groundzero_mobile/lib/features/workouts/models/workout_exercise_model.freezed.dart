// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'workout_exercise_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

WorkoutExerciseModel _$WorkoutExerciseModelFromJson(Map<String, dynamic> json) {
  return _WorkoutExerciseModel.fromJson(json);
}

/// @nodoc
mixin _$WorkoutExerciseModel {
  int get id => throw _privateConstructorUsedError;
  int get exerciseId => throw _privateConstructorUsedError;
  String get exerciseName => throw _privateConstructorUsedError;
  int get muscleGroup => throw _privateConstructorUsedError;
  int get sets => throw _privateConstructorUsedError;
  int get reps => throw _privateConstructorUsedError;
  double? get weight => throw _privateConstructorUsedError;
  int? get restSeconds => throw _privateConstructorUsedError;
  int get orderIndex => throw _privateConstructorUsedError;

  /// Serializes this WorkoutExerciseModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WorkoutExerciseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WorkoutExerciseModelCopyWith<WorkoutExerciseModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WorkoutExerciseModelCopyWith<$Res> {
  factory $WorkoutExerciseModelCopyWith(
    WorkoutExerciseModel value,
    $Res Function(WorkoutExerciseModel) then,
  ) = _$WorkoutExerciseModelCopyWithImpl<$Res, WorkoutExerciseModel>;
  @useResult
  $Res call({
    int id,
    int exerciseId,
    String exerciseName,
    int muscleGroup,
    int sets,
    int reps,
    double? weight,
    int? restSeconds,
    int orderIndex,
  });
}

/// @nodoc
class _$WorkoutExerciseModelCopyWithImpl<
  $Res,
  $Val extends WorkoutExerciseModel
>
    implements $WorkoutExerciseModelCopyWith<$Res> {
  _$WorkoutExerciseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WorkoutExerciseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? exerciseId = null,
    Object? exerciseName = null,
    Object? muscleGroup = null,
    Object? sets = null,
    Object? reps = null,
    Object? weight = freezed,
    Object? restSeconds = freezed,
    Object? orderIndex = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            exerciseId: null == exerciseId
                ? _value.exerciseId
                : exerciseId // ignore: cast_nullable_to_non_nullable
                      as int,
            exerciseName: null == exerciseName
                ? _value.exerciseName
                : exerciseName // ignore: cast_nullable_to_non_nullable
                      as String,
            muscleGroup: null == muscleGroup
                ? _value.muscleGroup
                : muscleGroup // ignore: cast_nullable_to_non_nullable
                      as int,
            sets: null == sets
                ? _value.sets
                : sets // ignore: cast_nullable_to_non_nullable
                      as int,
            reps: null == reps
                ? _value.reps
                : reps // ignore: cast_nullable_to_non_nullable
                      as int,
            weight: freezed == weight
                ? _value.weight
                : weight // ignore: cast_nullable_to_non_nullable
                      as double?,
            restSeconds: freezed == restSeconds
                ? _value.restSeconds
                : restSeconds // ignore: cast_nullable_to_non_nullable
                      as int?,
            orderIndex: null == orderIndex
                ? _value.orderIndex
                : orderIndex // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$WorkoutExerciseModelImplCopyWith<$Res>
    implements $WorkoutExerciseModelCopyWith<$Res> {
  factory _$$WorkoutExerciseModelImplCopyWith(
    _$WorkoutExerciseModelImpl value,
    $Res Function(_$WorkoutExerciseModelImpl) then,
  ) = __$$WorkoutExerciseModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    int exerciseId,
    String exerciseName,
    int muscleGroup,
    int sets,
    int reps,
    double? weight,
    int? restSeconds,
    int orderIndex,
  });
}

/// @nodoc
class __$$WorkoutExerciseModelImplCopyWithImpl<$Res>
    extends _$WorkoutExerciseModelCopyWithImpl<$Res, _$WorkoutExerciseModelImpl>
    implements _$$WorkoutExerciseModelImplCopyWith<$Res> {
  __$$WorkoutExerciseModelImplCopyWithImpl(
    _$WorkoutExerciseModelImpl _value,
    $Res Function(_$WorkoutExerciseModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WorkoutExerciseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? exerciseId = null,
    Object? exerciseName = null,
    Object? muscleGroup = null,
    Object? sets = null,
    Object? reps = null,
    Object? weight = freezed,
    Object? restSeconds = freezed,
    Object? orderIndex = null,
  }) {
    return _then(
      _$WorkoutExerciseModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        exerciseId: null == exerciseId
            ? _value.exerciseId
            : exerciseId // ignore: cast_nullable_to_non_nullable
                  as int,
        exerciseName: null == exerciseName
            ? _value.exerciseName
            : exerciseName // ignore: cast_nullable_to_non_nullable
                  as String,
        muscleGroup: null == muscleGroup
            ? _value.muscleGroup
            : muscleGroup // ignore: cast_nullable_to_non_nullable
                  as int,
        sets: null == sets
            ? _value.sets
            : sets // ignore: cast_nullable_to_non_nullable
                  as int,
        reps: null == reps
            ? _value.reps
            : reps // ignore: cast_nullable_to_non_nullable
                  as int,
        weight: freezed == weight
            ? _value.weight
            : weight // ignore: cast_nullable_to_non_nullable
                  as double?,
        restSeconds: freezed == restSeconds
            ? _value.restSeconds
            : restSeconds // ignore: cast_nullable_to_non_nullable
                  as int?,
        orderIndex: null == orderIndex
            ? _value.orderIndex
            : orderIndex // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$WorkoutExerciseModelImpl implements _WorkoutExerciseModel {
  const _$WorkoutExerciseModelImpl({
    required this.id,
    required this.exerciseId,
    required this.exerciseName,
    required this.muscleGroup,
    required this.sets,
    required this.reps,
    this.weight,
    this.restSeconds,
    required this.orderIndex,
  });

  factory _$WorkoutExerciseModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$WorkoutExerciseModelImplFromJson(json);

  @override
  final int id;
  @override
  final int exerciseId;
  @override
  final String exerciseName;
  @override
  final int muscleGroup;
  @override
  final int sets;
  @override
  final int reps;
  @override
  final double? weight;
  @override
  final int? restSeconds;
  @override
  final int orderIndex;

  @override
  String toString() {
    return 'WorkoutExerciseModel(id: $id, exerciseId: $exerciseId, exerciseName: $exerciseName, muscleGroup: $muscleGroup, sets: $sets, reps: $reps, weight: $weight, restSeconds: $restSeconds, orderIndex: $orderIndex)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WorkoutExerciseModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.exerciseId, exerciseId) ||
                other.exerciseId == exerciseId) &&
            (identical(other.exerciseName, exerciseName) ||
                other.exerciseName == exerciseName) &&
            (identical(other.muscleGroup, muscleGroup) ||
                other.muscleGroup == muscleGroup) &&
            (identical(other.sets, sets) || other.sets == sets) &&
            (identical(other.reps, reps) || other.reps == reps) &&
            (identical(other.weight, weight) || other.weight == weight) &&
            (identical(other.restSeconds, restSeconds) ||
                other.restSeconds == restSeconds) &&
            (identical(other.orderIndex, orderIndex) ||
                other.orderIndex == orderIndex));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    exerciseId,
    exerciseName,
    muscleGroup,
    sets,
    reps,
    weight,
    restSeconds,
    orderIndex,
  );

  /// Create a copy of WorkoutExerciseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WorkoutExerciseModelImplCopyWith<_$WorkoutExerciseModelImpl>
  get copyWith =>
      __$$WorkoutExerciseModelImplCopyWithImpl<_$WorkoutExerciseModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$WorkoutExerciseModelImplToJson(this);
  }
}

abstract class _WorkoutExerciseModel implements WorkoutExerciseModel {
  const factory _WorkoutExerciseModel({
    required final int id,
    required final int exerciseId,
    required final String exerciseName,
    required final int muscleGroup,
    required final int sets,
    required final int reps,
    final double? weight,
    final int? restSeconds,
    required final int orderIndex,
  }) = _$WorkoutExerciseModelImpl;

  factory _WorkoutExerciseModel.fromJson(Map<String, dynamic> json) =
      _$WorkoutExerciseModelImpl.fromJson;

  @override
  int get id;
  @override
  int get exerciseId;
  @override
  String get exerciseName;
  @override
  int get muscleGroup;
  @override
  int get sets;
  @override
  int get reps;
  @override
  double? get weight;
  @override
  int? get restSeconds;
  @override
  int get orderIndex;

  /// Create a copy of WorkoutExerciseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WorkoutExerciseModelImplCopyWith<_$WorkoutExerciseModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}
