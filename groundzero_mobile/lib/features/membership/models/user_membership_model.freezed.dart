// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_membership_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

UserMembershipModel _$UserMembershipModelFromJson(Map<String, dynamic> json) {
  return _UserMembershipModel.fromJson(json);
}

/// @nodoc
mixin _$UserMembershipModel {
  int get id => throw _privateConstructorUsedError;
  int get userId => throw _privateConstructorUsedError;
  String get userFullName => throw _privateConstructorUsedError;
  String get userEmail => throw _privateConstructorUsedError;
  String get planName => throw _privateConstructorUsedError;
  double get planPrice => throw _privateConstructorUsedError;
  int get durationDays => throw _privateConstructorUsedError;
  DateTime get startDate => throw _privateConstructorUsedError;
  DateTime get endDate => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this UserMembershipModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserMembershipModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserMembershipModelCopyWith<UserMembershipModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserMembershipModelCopyWith<$Res> {
  factory $UserMembershipModelCopyWith(
    UserMembershipModel value,
    $Res Function(UserMembershipModel) then,
  ) = _$UserMembershipModelCopyWithImpl<$Res, UserMembershipModel>;
  @useResult
  $Res call({
    int id,
    int userId,
    String userFullName,
    String userEmail,
    String planName,
    double planPrice,
    int durationDays,
    DateTime startDate,
    DateTime endDate,
    String status,
    DateTime createdAt,
  });
}

/// @nodoc
class _$UserMembershipModelCopyWithImpl<$Res, $Val extends UserMembershipModel>
    implements $UserMembershipModelCopyWith<$Res> {
  _$UserMembershipModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserMembershipModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? userFullName = null,
    Object? userEmail = null,
    Object? planName = null,
    Object? planPrice = null,
    Object? durationDays = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? status = null,
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
            userEmail: null == userEmail
                ? _value.userEmail
                : userEmail // ignore: cast_nullable_to_non_nullable
                      as String,
            planName: null == planName
                ? _value.planName
                : planName // ignore: cast_nullable_to_non_nullable
                      as String,
            planPrice: null == planPrice
                ? _value.planPrice
                : planPrice // ignore: cast_nullable_to_non_nullable
                      as double,
            durationDays: null == durationDays
                ? _value.durationDays
                : durationDays // ignore: cast_nullable_to_non_nullable
                      as int,
            startDate: null == startDate
                ? _value.startDate
                : startDate // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            endDate: null == endDate
                ? _value.endDate
                : endDate // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
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
abstract class _$$UserMembershipModelImplCopyWith<$Res>
    implements $UserMembershipModelCopyWith<$Res> {
  factory _$$UserMembershipModelImplCopyWith(
    _$UserMembershipModelImpl value,
    $Res Function(_$UserMembershipModelImpl) then,
  ) = __$$UserMembershipModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    int userId,
    String userFullName,
    String userEmail,
    String planName,
    double planPrice,
    int durationDays,
    DateTime startDate,
    DateTime endDate,
    String status,
    DateTime createdAt,
  });
}

/// @nodoc
class __$$UserMembershipModelImplCopyWithImpl<$Res>
    extends _$UserMembershipModelCopyWithImpl<$Res, _$UserMembershipModelImpl>
    implements _$$UserMembershipModelImplCopyWith<$Res> {
  __$$UserMembershipModelImplCopyWithImpl(
    _$UserMembershipModelImpl _value,
    $Res Function(_$UserMembershipModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserMembershipModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? userFullName = null,
    Object? userEmail = null,
    Object? planName = null,
    Object? planPrice = null,
    Object? durationDays = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? status = null,
    Object? createdAt = null,
  }) {
    return _then(
      _$UserMembershipModelImpl(
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
        userEmail: null == userEmail
            ? _value.userEmail
            : userEmail // ignore: cast_nullable_to_non_nullable
                  as String,
        planName: null == planName
            ? _value.planName
            : planName // ignore: cast_nullable_to_non_nullable
                  as String,
        planPrice: null == planPrice
            ? _value.planPrice
            : planPrice // ignore: cast_nullable_to_non_nullable
                  as double,
        durationDays: null == durationDays
            ? _value.durationDays
            : durationDays // ignore: cast_nullable_to_non_nullable
                  as int,
        startDate: null == startDate
            ? _value.startDate
            : startDate // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        endDate: null == endDate
            ? _value.endDate
            : endDate // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
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
class _$UserMembershipModelImpl implements _UserMembershipModel {
  const _$UserMembershipModelImpl({
    required this.id,
    required this.userId,
    required this.userFullName,
    required this.userEmail,
    required this.planName,
    required this.planPrice,
    required this.durationDays,
    required this.startDate,
    required this.endDate,
    required this.status,
    required this.createdAt,
  });

  factory _$UserMembershipModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserMembershipModelImplFromJson(json);

  @override
  final int id;
  @override
  final int userId;
  @override
  final String userFullName;
  @override
  final String userEmail;
  @override
  final String planName;
  @override
  final double planPrice;
  @override
  final int durationDays;
  @override
  final DateTime startDate;
  @override
  final DateTime endDate;
  @override
  final String status;
  @override
  final DateTime createdAt;

  @override
  String toString() {
    return 'UserMembershipModel(id: $id, userId: $userId, userFullName: $userFullName, userEmail: $userEmail, planName: $planName, planPrice: $planPrice, durationDays: $durationDays, startDate: $startDate, endDate: $endDate, status: $status, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserMembershipModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.userFullName, userFullName) ||
                other.userFullName == userFullName) &&
            (identical(other.userEmail, userEmail) ||
                other.userEmail == userEmail) &&
            (identical(other.planName, planName) ||
                other.planName == planName) &&
            (identical(other.planPrice, planPrice) ||
                other.planPrice == planPrice) &&
            (identical(other.durationDays, durationDays) ||
                other.durationDays == durationDays) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.status, status) || other.status == status) &&
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
    userEmail,
    planName,
    planPrice,
    durationDays,
    startDate,
    endDate,
    status,
    createdAt,
  );

  /// Create a copy of UserMembershipModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserMembershipModelImplCopyWith<_$UserMembershipModelImpl> get copyWith =>
      __$$UserMembershipModelImplCopyWithImpl<_$UserMembershipModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$UserMembershipModelImplToJson(this);
  }
}

abstract class _UserMembershipModel implements UserMembershipModel {
  const factory _UserMembershipModel({
    required final int id,
    required final int userId,
    required final String userFullName,
    required final String userEmail,
    required final String planName,
    required final double planPrice,
    required final int durationDays,
    required final DateTime startDate,
    required final DateTime endDate,
    required final String status,
    required final DateTime createdAt,
  }) = _$UserMembershipModelImpl;

  factory _UserMembershipModel.fromJson(Map<String, dynamic> json) =
      _$UserMembershipModelImpl.fromJson;

  @override
  int get id;
  @override
  int get userId;
  @override
  String get userFullName;
  @override
  String get userEmail;
  @override
  String get planName;
  @override
  double get planPrice;
  @override
  int get durationDays;
  @override
  DateTime get startDate;
  @override
  DateTime get endDate;
  @override
  String get status;
  @override
  DateTime get createdAt;

  /// Create a copy of UserMembershipModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserMembershipModelImplCopyWith<_$UserMembershipModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
