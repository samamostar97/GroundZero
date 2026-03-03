// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'add_workout_day_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

AddWorkoutDayRequest _$AddWorkoutDayRequestFromJson(Map<String, dynamic> json) {
  return _AddWorkoutDayRequest.fromJson(json);
}

/// @nodoc
mixin _$AddWorkoutDayRequest {
  int get dayOfWeek => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  /// Serializes this AddWorkoutDayRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AddWorkoutDayRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AddWorkoutDayRequestCopyWith<AddWorkoutDayRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddWorkoutDayRequestCopyWith<$Res> {
  factory $AddWorkoutDayRequestCopyWith(
    AddWorkoutDayRequest value,
    $Res Function(AddWorkoutDayRequest) then,
  ) = _$AddWorkoutDayRequestCopyWithImpl<$Res, AddWorkoutDayRequest>;
  @useResult
  $Res call({int dayOfWeek, String name});
}

/// @nodoc
class _$AddWorkoutDayRequestCopyWithImpl<
  $Res,
  $Val extends AddWorkoutDayRequest
>
    implements $AddWorkoutDayRequestCopyWith<$Res> {
  _$AddWorkoutDayRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AddWorkoutDayRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? dayOfWeek = null, Object? name = null}) {
    return _then(
      _value.copyWith(
            dayOfWeek: null == dayOfWeek
                ? _value.dayOfWeek
                : dayOfWeek // ignore: cast_nullable_to_non_nullable
                      as int,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AddWorkoutDayRequestImplCopyWith<$Res>
    implements $AddWorkoutDayRequestCopyWith<$Res> {
  factory _$$AddWorkoutDayRequestImplCopyWith(
    _$AddWorkoutDayRequestImpl value,
    $Res Function(_$AddWorkoutDayRequestImpl) then,
  ) = __$$AddWorkoutDayRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int dayOfWeek, String name});
}

/// @nodoc
class __$$AddWorkoutDayRequestImplCopyWithImpl<$Res>
    extends _$AddWorkoutDayRequestCopyWithImpl<$Res, _$AddWorkoutDayRequestImpl>
    implements _$$AddWorkoutDayRequestImplCopyWith<$Res> {
  __$$AddWorkoutDayRequestImplCopyWithImpl(
    _$AddWorkoutDayRequestImpl _value,
    $Res Function(_$AddWorkoutDayRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AddWorkoutDayRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? dayOfWeek = null, Object? name = null}) {
    return _then(
      _$AddWorkoutDayRequestImpl(
        dayOfWeek: null == dayOfWeek
            ? _value.dayOfWeek
            : dayOfWeek // ignore: cast_nullable_to_non_nullable
                  as int,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AddWorkoutDayRequestImpl implements _AddWorkoutDayRequest {
  const _$AddWorkoutDayRequestImpl({
    required this.dayOfWeek,
    required this.name,
  });

  factory _$AddWorkoutDayRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$AddWorkoutDayRequestImplFromJson(json);

  @override
  final int dayOfWeek;
  @override
  final String name;

  @override
  String toString() {
    return 'AddWorkoutDayRequest(dayOfWeek: $dayOfWeek, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddWorkoutDayRequestImpl &&
            (identical(other.dayOfWeek, dayOfWeek) ||
                other.dayOfWeek == dayOfWeek) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, dayOfWeek, name);

  /// Create a copy of AddWorkoutDayRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AddWorkoutDayRequestImplCopyWith<_$AddWorkoutDayRequestImpl>
  get copyWith =>
      __$$AddWorkoutDayRequestImplCopyWithImpl<_$AddWorkoutDayRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$AddWorkoutDayRequestImplToJson(this);
  }
}

abstract class _AddWorkoutDayRequest implements AddWorkoutDayRequest {
  const factory _AddWorkoutDayRequest({
    required final int dayOfWeek,
    required final String name,
  }) = _$AddWorkoutDayRequestImpl;

  factory _AddWorkoutDayRequest.fromJson(Map<String, dynamic> json) =
      _$AddWorkoutDayRequestImpl.fromJson;

  @override
  int get dayOfWeek;
  @override
  String get name;

  /// Create a copy of AddWorkoutDayRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AddWorkoutDayRequestImplCopyWith<_$AddWorkoutDayRequestImpl>
  get copyWith => throw _privateConstructorUsedError;
}
