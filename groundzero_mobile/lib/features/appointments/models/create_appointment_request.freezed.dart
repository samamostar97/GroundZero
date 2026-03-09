// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_appointment_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

CreateAppointmentRequest _$CreateAppointmentRequestFromJson(
  Map<String, dynamic> json,
) {
  return _CreateAppointmentRequest.fromJson(json);
}

/// @nodoc
mixin _$CreateAppointmentRequest {
  int get staffId => throw _privateConstructorUsedError;
  DateTime get scheduledAt => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;

  /// Serializes this CreateAppointmentRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CreateAppointmentRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CreateAppointmentRequestCopyWith<CreateAppointmentRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateAppointmentRequestCopyWith<$Res> {
  factory $CreateAppointmentRequestCopyWith(
    CreateAppointmentRequest value,
    $Res Function(CreateAppointmentRequest) then,
  ) = _$CreateAppointmentRequestCopyWithImpl<$Res, CreateAppointmentRequest>;
  @useResult
  $Res call({int staffId, DateTime scheduledAt, String? notes});
}

/// @nodoc
class _$CreateAppointmentRequestCopyWithImpl<
  $Res,
  $Val extends CreateAppointmentRequest
>
    implements $CreateAppointmentRequestCopyWith<$Res> {
  _$CreateAppointmentRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CreateAppointmentRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? staffId = null,
    Object? scheduledAt = null,
    Object? notes = freezed,
  }) {
    return _then(
      _value.copyWith(
            staffId: null == staffId
                ? _value.staffId
                : staffId // ignore: cast_nullable_to_non_nullable
                      as int,
            scheduledAt: null == scheduledAt
                ? _value.scheduledAt
                : scheduledAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            notes: freezed == notes
                ? _value.notes
                : notes // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CreateAppointmentRequestImplCopyWith<$Res>
    implements $CreateAppointmentRequestCopyWith<$Res> {
  factory _$$CreateAppointmentRequestImplCopyWith(
    _$CreateAppointmentRequestImpl value,
    $Res Function(_$CreateAppointmentRequestImpl) then,
  ) = __$$CreateAppointmentRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int staffId, DateTime scheduledAt, String? notes});
}

/// @nodoc
class __$$CreateAppointmentRequestImplCopyWithImpl<$Res>
    extends
        _$CreateAppointmentRequestCopyWithImpl<
          $Res,
          _$CreateAppointmentRequestImpl
        >
    implements _$$CreateAppointmentRequestImplCopyWith<$Res> {
  __$$CreateAppointmentRequestImplCopyWithImpl(
    _$CreateAppointmentRequestImpl _value,
    $Res Function(_$CreateAppointmentRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CreateAppointmentRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? staffId = null,
    Object? scheduledAt = null,
    Object? notes = freezed,
  }) {
    return _then(
      _$CreateAppointmentRequestImpl(
        staffId: null == staffId
            ? _value.staffId
            : staffId // ignore: cast_nullable_to_non_nullable
                  as int,
        scheduledAt: null == scheduledAt
            ? _value.scheduledAt
            : scheduledAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        notes: freezed == notes
            ? _value.notes
            : notes // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CreateAppointmentRequestImpl implements _CreateAppointmentRequest {
  const _$CreateAppointmentRequestImpl({
    required this.staffId,
    required this.scheduledAt,
    this.notes,
  });

  factory _$CreateAppointmentRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$CreateAppointmentRequestImplFromJson(json);

  @override
  final int staffId;
  @override
  final DateTime scheduledAt;
  @override
  final String? notes;

  @override
  String toString() {
    return 'CreateAppointmentRequest(staffId: $staffId, scheduledAt: $scheduledAt, notes: $notes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateAppointmentRequestImpl &&
            (identical(other.staffId, staffId) || other.staffId == staffId) &&
            (identical(other.scheduledAt, scheduledAt) ||
                other.scheduledAt == scheduledAt) &&
            (identical(other.notes, notes) || other.notes == notes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, staffId, scheduledAt, notes);

  /// Create a copy of CreateAppointmentRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateAppointmentRequestImplCopyWith<_$CreateAppointmentRequestImpl>
  get copyWith =>
      __$$CreateAppointmentRequestImplCopyWithImpl<
        _$CreateAppointmentRequestImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CreateAppointmentRequestImplToJson(this);
  }
}

abstract class _CreateAppointmentRequest implements CreateAppointmentRequest {
  const factory _CreateAppointmentRequest({
    required final int staffId,
    required final DateTime scheduledAt,
    final String? notes,
  }) = _$CreateAppointmentRequestImpl;

  factory _CreateAppointmentRequest.fromJson(Map<String, dynamic> json) =
      _$CreateAppointmentRequestImpl.fromJson;

  @override
  int get staffId;
  @override
  DateTime get scheduledAt;
  @override
  String? get notes;

  /// Create a copy of CreateAppointmentRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreateAppointmentRequestImplCopyWith<_$CreateAppointmentRequestImpl>
  get copyWith => throw _privateConstructorUsedError;
}
