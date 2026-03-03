// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'add_workout_exercise_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

AddWorkoutExerciseRequest _$AddWorkoutExerciseRequestFromJson(
  Map<String, dynamic> json,
) {
  return _AddWorkoutExerciseRequest.fromJson(json);
}

/// @nodoc
mixin _$AddWorkoutExerciseRequest {
  int get exerciseId => throw _privateConstructorUsedError;
  int get sets => throw _privateConstructorUsedError;
  int get reps => throw _privateConstructorUsedError;
  double? get weight => throw _privateConstructorUsedError;
  int? get restSeconds => throw _privateConstructorUsedError;
  int get orderIndex => throw _privateConstructorUsedError;

  /// Serializes this AddWorkoutExerciseRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AddWorkoutExerciseRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AddWorkoutExerciseRequestCopyWith<AddWorkoutExerciseRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddWorkoutExerciseRequestCopyWith<$Res> {
  factory $AddWorkoutExerciseRequestCopyWith(
    AddWorkoutExerciseRequest value,
    $Res Function(AddWorkoutExerciseRequest) then,
  ) = _$AddWorkoutExerciseRequestCopyWithImpl<$Res, AddWorkoutExerciseRequest>;
  @useResult
  $Res call({
    int exerciseId,
    int sets,
    int reps,
    double? weight,
    int? restSeconds,
    int orderIndex,
  });
}

/// @nodoc
class _$AddWorkoutExerciseRequestCopyWithImpl<
  $Res,
  $Val extends AddWorkoutExerciseRequest
>
    implements $AddWorkoutExerciseRequestCopyWith<$Res> {
  _$AddWorkoutExerciseRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AddWorkoutExerciseRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? exerciseId = null,
    Object? sets = null,
    Object? reps = null,
    Object? weight = freezed,
    Object? restSeconds = freezed,
    Object? orderIndex = null,
  }) {
    return _then(
      _value.copyWith(
            exerciseId: null == exerciseId
                ? _value.exerciseId
                : exerciseId // ignore: cast_nullable_to_non_nullable
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
abstract class _$$AddWorkoutExerciseRequestImplCopyWith<$Res>
    implements $AddWorkoutExerciseRequestCopyWith<$Res> {
  factory _$$AddWorkoutExerciseRequestImplCopyWith(
    _$AddWorkoutExerciseRequestImpl value,
    $Res Function(_$AddWorkoutExerciseRequestImpl) then,
  ) = __$$AddWorkoutExerciseRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int exerciseId,
    int sets,
    int reps,
    double? weight,
    int? restSeconds,
    int orderIndex,
  });
}

/// @nodoc
class __$$AddWorkoutExerciseRequestImplCopyWithImpl<$Res>
    extends
        _$AddWorkoutExerciseRequestCopyWithImpl<
          $Res,
          _$AddWorkoutExerciseRequestImpl
        >
    implements _$$AddWorkoutExerciseRequestImplCopyWith<$Res> {
  __$$AddWorkoutExerciseRequestImplCopyWithImpl(
    _$AddWorkoutExerciseRequestImpl _value,
    $Res Function(_$AddWorkoutExerciseRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AddWorkoutExerciseRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? exerciseId = null,
    Object? sets = null,
    Object? reps = null,
    Object? weight = freezed,
    Object? restSeconds = freezed,
    Object? orderIndex = null,
  }) {
    return _then(
      _$AddWorkoutExerciseRequestImpl(
        exerciseId: null == exerciseId
            ? _value.exerciseId
            : exerciseId // ignore: cast_nullable_to_non_nullable
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
class _$AddWorkoutExerciseRequestImpl implements _AddWorkoutExerciseRequest {
  const _$AddWorkoutExerciseRequestImpl({
    required this.exerciseId,
    required this.sets,
    required this.reps,
    this.weight,
    this.restSeconds,
    required this.orderIndex,
  });

  factory _$AddWorkoutExerciseRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$AddWorkoutExerciseRequestImplFromJson(json);

  @override
  final int exerciseId;
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
    return 'AddWorkoutExerciseRequest(exerciseId: $exerciseId, sets: $sets, reps: $reps, weight: $weight, restSeconds: $restSeconds, orderIndex: $orderIndex)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddWorkoutExerciseRequestImpl &&
            (identical(other.exerciseId, exerciseId) ||
                other.exerciseId == exerciseId) &&
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
    exerciseId,
    sets,
    reps,
    weight,
    restSeconds,
    orderIndex,
  );

  /// Create a copy of AddWorkoutExerciseRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AddWorkoutExerciseRequestImplCopyWith<_$AddWorkoutExerciseRequestImpl>
  get copyWith =>
      __$$AddWorkoutExerciseRequestImplCopyWithImpl<
        _$AddWorkoutExerciseRequestImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AddWorkoutExerciseRequestImplToJson(this);
  }
}

abstract class _AddWorkoutExerciseRequest implements AddWorkoutExerciseRequest {
  const factory _AddWorkoutExerciseRequest({
    required final int exerciseId,
    required final int sets,
    required final int reps,
    final double? weight,
    final int? restSeconds,
    required final int orderIndex,
  }) = _$AddWorkoutExerciseRequestImpl;

  factory _AddWorkoutExerciseRequest.fromJson(Map<String, dynamic> json) =
      _$AddWorkoutExerciseRequestImpl.fromJson;

  @override
  int get exerciseId;
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

  /// Create a copy of AddWorkoutExerciseRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AddWorkoutExerciseRequestImplCopyWith<_$AddWorkoutExerciseRequestImpl>
  get copyWith => throw _privateConstructorUsedError;
}
