// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'workout_plan_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

WorkoutPlanModel _$WorkoutPlanModelFromJson(Map<String, dynamic> json) {
  return _WorkoutPlanModel.fromJson(json);
}

/// @nodoc
mixin _$WorkoutPlanModel {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  List<WorkoutDayModel> get days => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this WorkoutPlanModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WorkoutPlanModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WorkoutPlanModelCopyWith<WorkoutPlanModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WorkoutPlanModelCopyWith<$Res> {
  factory $WorkoutPlanModelCopyWith(
    WorkoutPlanModel value,
    $Res Function(WorkoutPlanModel) then,
  ) = _$WorkoutPlanModelCopyWithImpl<$Res, WorkoutPlanModel>;
  @useResult
  $Res call({
    int id,
    String name,
    String? description,
    List<WorkoutDayModel> days,
    DateTime createdAt,
  });
}

/// @nodoc
class _$WorkoutPlanModelCopyWithImpl<$Res, $Val extends WorkoutPlanModel>
    implements $WorkoutPlanModelCopyWith<$Res> {
  _$WorkoutPlanModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WorkoutPlanModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? days = null,
    Object? createdAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            days: null == days
                ? _value.days
                : days // ignore: cast_nullable_to_non_nullable
                      as List<WorkoutDayModel>,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$WorkoutPlanModelImplCopyWith<$Res>
    implements $WorkoutPlanModelCopyWith<$Res> {
  factory _$$WorkoutPlanModelImplCopyWith(
    _$WorkoutPlanModelImpl value,
    $Res Function(_$WorkoutPlanModelImpl) then,
  ) = __$$WorkoutPlanModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String name,
    String? description,
    List<WorkoutDayModel> days,
    DateTime createdAt,
  });
}

/// @nodoc
class __$$WorkoutPlanModelImplCopyWithImpl<$Res>
    extends _$WorkoutPlanModelCopyWithImpl<$Res, _$WorkoutPlanModelImpl>
    implements _$$WorkoutPlanModelImplCopyWith<$Res> {
  __$$WorkoutPlanModelImplCopyWithImpl(
    _$WorkoutPlanModelImpl _value,
    $Res Function(_$WorkoutPlanModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WorkoutPlanModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? days = null,
    Object? createdAt = null,
  }) {
    return _then(
      _$WorkoutPlanModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        days: null == days
            ? _value._days
            : days // ignore: cast_nullable_to_non_nullable
                  as List<WorkoutDayModel>,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$WorkoutPlanModelImpl implements _WorkoutPlanModel {
  const _$WorkoutPlanModelImpl({
    required this.id,
    required this.name,
    this.description,
    final List<WorkoutDayModel> days = const [],
    required this.createdAt,
  }) : _days = days;

  factory _$WorkoutPlanModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$WorkoutPlanModelImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final String? description;
  final List<WorkoutDayModel> _days;
  @override
  @JsonKey()
  List<WorkoutDayModel> get days {
    if (_days is EqualUnmodifiableListView) return _days;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_days);
  }

  @override
  final DateTime createdAt;

  @override
  String toString() {
    return 'WorkoutPlanModel(id: $id, name: $name, description: $description, days: $days, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WorkoutPlanModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(other._days, _days) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    description,
    const DeepCollectionEquality().hash(_days),
    createdAt,
  );

  /// Create a copy of WorkoutPlanModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WorkoutPlanModelImplCopyWith<_$WorkoutPlanModelImpl> get copyWith =>
      __$$WorkoutPlanModelImplCopyWithImpl<_$WorkoutPlanModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$WorkoutPlanModelImplToJson(this);
  }
}

abstract class _WorkoutPlanModel implements WorkoutPlanModel {
  const factory _WorkoutPlanModel({
    required final int id,
    required final String name,
    final String? description,
    final List<WorkoutDayModel> days,
    required final DateTime createdAt,
  }) = _$WorkoutPlanModelImpl;

  factory _WorkoutPlanModel.fromJson(Map<String, dynamic> json) =
      _$WorkoutPlanModelImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  String? get description;
  @override
  List<WorkoutDayModel> get days;
  @override
  DateTime get createdAt;

  /// Create a copy of WorkoutPlanModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WorkoutPlanModelImplCopyWith<_$WorkoutPlanModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
