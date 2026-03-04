// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'gym_visit_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

GymVisitModel _$GymVisitModelFromJson(Map<String, dynamic> json) {
  return _GymVisitModel.fromJson(json);
}

/// @nodoc
mixin _$GymVisitModel {
  int get id => throw _privateConstructorUsedError;
  int get userId => throw _privateConstructorUsedError;
  String get userFullName => throw _privateConstructorUsedError;
  DateTime get checkInAt => throw _privateConstructorUsedError;
  DateTime? get checkOutAt => throw _privateConstructorUsedError;
  int? get durationMinutes => throw _privateConstructorUsedError;
  int get xpEarned => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this GymVisitModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GymVisitModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GymVisitModelCopyWith<GymVisitModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GymVisitModelCopyWith<$Res> {
  factory $GymVisitModelCopyWith(
    GymVisitModel value,
    $Res Function(GymVisitModel) then,
  ) = _$GymVisitModelCopyWithImpl<$Res, GymVisitModel>;
  @useResult
  $Res call({
    int id,
    int userId,
    String userFullName,
    DateTime checkInAt,
    DateTime? checkOutAt,
    int? durationMinutes,
    int xpEarned,
    DateTime createdAt,
  });
}

/// @nodoc
class _$GymVisitModelCopyWithImpl<$Res, $Val extends GymVisitModel>
    implements $GymVisitModelCopyWith<$Res> {
  _$GymVisitModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GymVisitModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? userFullName = null,
    Object? checkInAt = null,
    Object? checkOutAt = freezed,
    Object? durationMinutes = freezed,
    Object? xpEarned = null,
    Object? createdAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as int,
            userFullName: null == userFullName
                ? _value.userFullName
                : userFullName // ignore: cast_nullable_to_non_nullable
                      as String,
            checkInAt: null == checkInAt
                ? _value.checkInAt
                : checkInAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            checkOutAt: freezed == checkOutAt
                ? _value.checkOutAt
                : checkOutAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            durationMinutes: freezed == durationMinutes
                ? _value.durationMinutes
                : durationMinutes // ignore: cast_nullable_to_non_nullable
                      as int?,
            xpEarned: null == xpEarned
                ? _value.xpEarned
                : xpEarned // ignore: cast_nullable_to_non_nullable
                      as int,
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
abstract class _$$GymVisitModelImplCopyWith<$Res>
    implements $GymVisitModelCopyWith<$Res> {
  factory _$$GymVisitModelImplCopyWith(
    _$GymVisitModelImpl value,
    $Res Function(_$GymVisitModelImpl) then,
  ) = __$$GymVisitModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    int userId,
    String userFullName,
    DateTime checkInAt,
    DateTime? checkOutAt,
    int? durationMinutes,
    int xpEarned,
    DateTime createdAt,
  });
}

/// @nodoc
class __$$GymVisitModelImplCopyWithImpl<$Res>
    extends _$GymVisitModelCopyWithImpl<$Res, _$GymVisitModelImpl>
    implements _$$GymVisitModelImplCopyWith<$Res> {
  __$$GymVisitModelImplCopyWithImpl(
    _$GymVisitModelImpl _value,
    $Res Function(_$GymVisitModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GymVisitModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? userFullName = null,
    Object? checkInAt = null,
    Object? checkOutAt = freezed,
    Object? durationMinutes = freezed,
    Object? xpEarned = null,
    Object? createdAt = null,
  }) {
    return _then(
      _$GymVisitModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as int,
        userFullName: null == userFullName
            ? _value.userFullName
            : userFullName // ignore: cast_nullable_to_non_nullable
                  as String,
        checkInAt: null == checkInAt
            ? _value.checkInAt
            : checkInAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        checkOutAt: freezed == checkOutAt
            ? _value.checkOutAt
            : checkOutAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        durationMinutes: freezed == durationMinutes
            ? _value.durationMinutes
            : durationMinutes // ignore: cast_nullable_to_non_nullable
                  as int?,
        xpEarned: null == xpEarned
            ? _value.xpEarned
            : xpEarned // ignore: cast_nullable_to_non_nullable
                  as int,
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
class _$GymVisitModelImpl implements _GymVisitModel {
  const _$GymVisitModelImpl({
    required this.id,
    required this.userId,
    required this.userFullName,
    required this.checkInAt,
    this.checkOutAt,
    this.durationMinutes,
    required this.xpEarned,
    required this.createdAt,
  });

  factory _$GymVisitModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$GymVisitModelImplFromJson(json);

  @override
  final int id;
  @override
  final int userId;
  @override
  final String userFullName;
  @override
  final DateTime checkInAt;
  @override
  final DateTime? checkOutAt;
  @override
  final int? durationMinutes;
  @override
  final int xpEarned;
  @override
  final DateTime createdAt;

  @override
  String toString() {
    return 'GymVisitModel(id: $id, userId: $userId, userFullName: $userFullName, checkInAt: $checkInAt, checkOutAt: $checkOutAt, durationMinutes: $durationMinutes, xpEarned: $xpEarned, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GymVisitModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.userFullName, userFullName) ||
                other.userFullName == userFullName) &&
            (identical(other.checkInAt, checkInAt) ||
                other.checkInAt == checkInAt) &&
            (identical(other.checkOutAt, checkOutAt) ||
                other.checkOutAt == checkOutAt) &&
            (identical(other.durationMinutes, durationMinutes) ||
                other.durationMinutes == durationMinutes) &&
            (identical(other.xpEarned, xpEarned) ||
                other.xpEarned == xpEarned) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    userId,
    userFullName,
    checkInAt,
    checkOutAt,
    durationMinutes,
    xpEarned,
    createdAt,
  );

  /// Create a copy of GymVisitModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GymVisitModelImplCopyWith<_$GymVisitModelImpl> get copyWith =>
      __$$GymVisitModelImplCopyWithImpl<_$GymVisitModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GymVisitModelImplToJson(this);
  }
}

abstract class _GymVisitModel implements GymVisitModel {
  const factory _GymVisitModel({
    required final int id,
    required final int userId,
    required final String userFullName,
    required final DateTime checkInAt,
    final DateTime? checkOutAt,
    final int? durationMinutes,
    required final int xpEarned,
    required final DateTime createdAt,
  }) = _$GymVisitModelImpl;

  factory _GymVisitModel.fromJson(Map<String, dynamic> json) =
      _$GymVisitModelImpl.fromJson;

  @override
  int get id;
  @override
  int get userId;
  @override
  String get userFullName;
  @override
  DateTime get checkInAt;
  @override
  DateTime? get checkOutAt;
  @override
  int? get durationMinutes;
  @override
  int get xpEarned;
  @override
  DateTime get createdAt;

  /// Create a copy of GymVisitModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GymVisitModelImplCopyWith<_$GymVisitModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
