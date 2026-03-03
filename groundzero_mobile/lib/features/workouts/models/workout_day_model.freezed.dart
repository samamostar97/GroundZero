// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'workout_day_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

WorkoutDayModel _$WorkoutDayModelFromJson(Map<String, dynamic> json) {
  return _WorkoutDayModel.fromJson(json);
}

/// @nodoc
mixin _$WorkoutDayModel {
  int get id => throw _privateConstructorUsedError;
  int get dayOfWeek => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  List<WorkoutExerciseModel> get exercises =>
      throw _privateConstructorUsedError;

  /// Serializes this WorkoutDayModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WorkoutDayModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WorkoutDayModelCopyWith<WorkoutDayModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WorkoutDayModelCopyWith<$Res> {
  factory $WorkoutDayModelCopyWith(
    WorkoutDayModel value,
    $Res Function(WorkoutDayModel) then,
  ) = _$WorkoutDayModelCopyWithImpl<$Res, WorkoutDayModel>;
  @useResult
  $Res call({
    int id,
    int dayOfWeek,
    String name,
    List<WorkoutExerciseModel> exercises,
  });
}

/// @nodoc
class _$WorkoutDayModelCopyWithImpl<$Res, $Val extends WorkoutDayModel>
    implements $WorkoutDayModelCopyWith<$Res> {
  _$WorkoutDayModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WorkoutDayModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? dayOfWeek = null,
    Object? name = null,
    Object? exercises = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            dayOfWeek: null == dayOfWeek
                ? _value.dayOfWeek
                : dayOfWeek // ignore: cast_nullable_to_non_nullable
                      as int,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            exercises: null == exercises
                ? _value.exercises
                : exercises // ignore: cast_nullable_to_non_nullable
                      as List<WorkoutExerciseModel>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$WorkoutDayModelImplCopyWith<$Res>
    implements $WorkoutDayModelCopyWith<$Res> {
  factory _$$WorkoutDayModelImplCopyWith(
    _$WorkoutDayModelImpl value,
    $Res Function(_$WorkoutDayModelImpl) then,
  ) = __$$WorkoutDayModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    int dayOfWeek,
    String name,
    List<WorkoutExerciseModel> exercises,
  });
}

/// @nodoc
class __$$WorkoutDayModelImplCopyWithImpl<$Res>
    extends _$WorkoutDayModelCopyWithImpl<$Res, _$WorkoutDayModelImpl>
    implements _$$WorkoutDayModelImplCopyWith<$Res> {
  __$$WorkoutDayModelImplCopyWithImpl(
    _$WorkoutDayModelImpl _value,
    $Res Function(_$WorkoutDayModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WorkoutDayModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? dayOfWeek = null,
    Object? name = null,
    Object? exercises = null,
  }) {
    return _then(
      _$WorkoutDayModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        dayOfWeek: null == dayOfWeek
            ? _value.dayOfWeek
            : dayOfWeek // ignore: cast_nullable_to_non_nullable
                  as int,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        exercises: null == exercises
            ? _value._exercises
            : exercises // ignore: cast_nullable_to_non_nullable
                  as List<WorkoutExerciseModel>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$WorkoutDayModelImpl implements _WorkoutDayModel {
  const _$WorkoutDayModelImpl({
    required this.id,
    required this.dayOfWeek,
    required this.name,
    final List<WorkoutExerciseModel> exercises = const [],
  }) : _exercises = exercises;

  factory _$WorkoutDayModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$WorkoutDayModelImplFromJson(json);

  @override
  final int id;
  @override
  final int dayOfWeek;
  @override
  final String name;
  final List<WorkoutExerciseModel> _exercises;
  @override
  @JsonKey()
  List<WorkoutExerciseModel> get exercises {
    if (_exercises is EqualUnmodifiableListView) return _exercises;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_exercises);
  }

  @override
  String toString() {
    return 'WorkoutDayModel(id: $id, dayOfWeek: $dayOfWeek, name: $name, exercises: $exercises)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WorkoutDayModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.dayOfWeek, dayOfWeek) ||
                other.dayOfWeek == dayOfWeek) &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality().equals(
              other._exercises,
              _exercises,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    dayOfWeek,
    name,
    const DeepCollectionEquality().hash(_exercises),
  );

  /// Create a copy of WorkoutDayModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WorkoutDayModelImplCopyWith<_$WorkoutDayModelImpl> get copyWith =>
      __$$WorkoutDayModelImplCopyWithImpl<_$WorkoutDayModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$WorkoutDayModelImplToJson(this);
  }
}

abstract class _WorkoutDayModel implements WorkoutDayModel {
  const factory _WorkoutDayModel({
    required final int id,
    required final int dayOfWeek,
    required final String name,
    final List<WorkoutExerciseModel> exercises,
  }) = _$WorkoutDayModelImpl;

  factory _WorkoutDayModel.fromJson(Map<String, dynamic> json) =
      _$WorkoutDayModelImpl.fromJson;

  @override
  int get id;
  @override
  int get dayOfWeek;
  @override
  String get name;
  @override
  List<WorkoutExerciseModel> get exercises;

  /// Create a copy of WorkoutDayModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WorkoutDayModelImplCopyWith<_$WorkoutDayModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
