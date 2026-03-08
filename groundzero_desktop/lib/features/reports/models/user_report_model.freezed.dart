// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_report_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

UserReportModel _$UserReportModelFromJson(Map<String, dynamic> json) {
  return _UserReportModel.fromJson(json);
}

/// @nodoc
mixin _$UserReportModel {
  DateTime get from => throw _privateConstructorUsedError;
  DateTime get to => throw _privateConstructorUsedError;
  int get totalUsers => throw _privateConstructorUsedError;
  int get newUsersInPeriod => throw _privateConstructorUsedError;
  int get activeUsersInPeriod => throw _privateConstructorUsedError;
  double get retentionRate => throw _privateConstructorUsedError;
  List<MonthlyRegistrationItem> get monthlyRegistrations =>
      throw _privateConstructorUsedError;
  List<UserActivityItem> get mostActiveUsers =>
      throw _privateConstructorUsedError;

  /// Serializes this UserReportModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserReportModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserReportModelCopyWith<UserReportModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserReportModelCopyWith<$Res> {
  factory $UserReportModelCopyWith(
    UserReportModel value,
    $Res Function(UserReportModel) then,
  ) = _$UserReportModelCopyWithImpl<$Res, UserReportModel>;
  @useResult
  $Res call({
    DateTime from,
    DateTime to,
    int totalUsers,
    int newUsersInPeriod,
    int activeUsersInPeriod,
    double retentionRate,
    List<MonthlyRegistrationItem> monthlyRegistrations,
    List<UserActivityItem> mostActiveUsers,
  });
}

/// @nodoc
class _$UserReportModelCopyWithImpl<$Res, $Val extends UserReportModel>
    implements $UserReportModelCopyWith<$Res> {
  _$UserReportModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserReportModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? from = null,
    Object? to = null,
    Object? totalUsers = null,
    Object? newUsersInPeriod = null,
    Object? activeUsersInPeriod = null,
    Object? retentionRate = null,
    Object? monthlyRegistrations = null,
    Object? mostActiveUsers = null,
  }) {
    return _then(
      _value.copyWith(
            from: null == from
                ? _value.from
                : from // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            to: null == to
                ? _value.to
                : to // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            totalUsers: null == totalUsers
                ? _value.totalUsers
                : totalUsers // ignore: cast_nullable_to_non_nullable
                      as int,
            newUsersInPeriod: null == newUsersInPeriod
                ? _value.newUsersInPeriod
                : newUsersInPeriod // ignore: cast_nullable_to_non_nullable
                      as int,
            activeUsersInPeriod: null == activeUsersInPeriod
                ? _value.activeUsersInPeriod
                : activeUsersInPeriod // ignore: cast_nullable_to_non_nullable
                      as int,
            retentionRate: null == retentionRate
                ? _value.retentionRate
                : retentionRate // ignore: cast_nullable_to_non_nullable
                      as double,
            monthlyRegistrations: null == monthlyRegistrations
                ? _value.monthlyRegistrations
                : monthlyRegistrations // ignore: cast_nullable_to_non_nullable
                      as List<MonthlyRegistrationItem>,
            mostActiveUsers: null == mostActiveUsers
                ? _value.mostActiveUsers
                : mostActiveUsers // ignore: cast_nullable_to_non_nullable
                      as List<UserActivityItem>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UserReportModelImplCopyWith<$Res>
    implements $UserReportModelCopyWith<$Res> {
  factory _$$UserReportModelImplCopyWith(
    _$UserReportModelImpl value,
    $Res Function(_$UserReportModelImpl) then,
  ) = __$$UserReportModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    DateTime from,
    DateTime to,
    int totalUsers,
    int newUsersInPeriod,
    int activeUsersInPeriod,
    double retentionRate,
    List<MonthlyRegistrationItem> monthlyRegistrations,
    List<UserActivityItem> mostActiveUsers,
  });
}

/// @nodoc
class __$$UserReportModelImplCopyWithImpl<$Res>
    extends _$UserReportModelCopyWithImpl<$Res, _$UserReportModelImpl>
    implements _$$UserReportModelImplCopyWith<$Res> {
  __$$UserReportModelImplCopyWithImpl(
    _$UserReportModelImpl _value,
    $Res Function(_$UserReportModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserReportModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? from = null,
    Object? to = null,
    Object? totalUsers = null,
    Object? newUsersInPeriod = null,
    Object? activeUsersInPeriod = null,
    Object? retentionRate = null,
    Object? monthlyRegistrations = null,
    Object? mostActiveUsers = null,
  }) {
    return _then(
      _$UserReportModelImpl(
        from: null == from
            ? _value.from
            : from // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        to: null == to
            ? _value.to
            : to // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        totalUsers: null == totalUsers
            ? _value.totalUsers
            : totalUsers // ignore: cast_nullable_to_non_nullable
                  as int,
        newUsersInPeriod: null == newUsersInPeriod
            ? _value.newUsersInPeriod
            : newUsersInPeriod // ignore: cast_nullable_to_non_nullable
                  as int,
        activeUsersInPeriod: null == activeUsersInPeriod
            ? _value.activeUsersInPeriod
            : activeUsersInPeriod // ignore: cast_nullable_to_non_nullable
                  as int,
        retentionRate: null == retentionRate
            ? _value.retentionRate
            : retentionRate // ignore: cast_nullable_to_non_nullable
                  as double,
        monthlyRegistrations: null == monthlyRegistrations
            ? _value._monthlyRegistrations
            : monthlyRegistrations // ignore: cast_nullable_to_non_nullable
                  as List<MonthlyRegistrationItem>,
        mostActiveUsers: null == mostActiveUsers
            ? _value._mostActiveUsers
            : mostActiveUsers // ignore: cast_nullable_to_non_nullable
                  as List<UserActivityItem>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UserReportModelImpl implements _UserReportModel {
  const _$UserReportModelImpl({
    required this.from,
    required this.to,
    required this.totalUsers,
    required this.newUsersInPeriod,
    required this.activeUsersInPeriod,
    required this.retentionRate,
    required final List<MonthlyRegistrationItem> monthlyRegistrations,
    required final List<UserActivityItem> mostActiveUsers,
  }) : _monthlyRegistrations = monthlyRegistrations,
       _mostActiveUsers = mostActiveUsers;

  factory _$UserReportModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserReportModelImplFromJson(json);

  @override
  final DateTime from;
  @override
  final DateTime to;
  @override
  final int totalUsers;
  @override
  final int newUsersInPeriod;
  @override
  final int activeUsersInPeriod;
  @override
  final double retentionRate;
  final List<MonthlyRegistrationItem> _monthlyRegistrations;
  @override
  List<MonthlyRegistrationItem> get monthlyRegistrations {
    if (_monthlyRegistrations is EqualUnmodifiableListView)
      return _monthlyRegistrations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_monthlyRegistrations);
  }

  final List<UserActivityItem> _mostActiveUsers;
  @override
  List<UserActivityItem> get mostActiveUsers {
    if (_mostActiveUsers is EqualUnmodifiableListView) return _mostActiveUsers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_mostActiveUsers);
  }

  @override
  String toString() {
    return 'UserReportModel(from: $from, to: $to, totalUsers: $totalUsers, newUsersInPeriod: $newUsersInPeriod, activeUsersInPeriod: $activeUsersInPeriod, retentionRate: $retentionRate, monthlyRegistrations: $monthlyRegistrations, mostActiveUsers: $mostActiveUsers)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserReportModelImpl &&
            (identical(other.from, from) || other.from == from) &&
            (identical(other.to, to) || other.to == to) &&
            (identical(other.totalUsers, totalUsers) ||
                other.totalUsers == totalUsers) &&
            (identical(other.newUsersInPeriod, newUsersInPeriod) ||
                other.newUsersInPeriod == newUsersInPeriod) &&
            (identical(other.activeUsersInPeriod, activeUsersInPeriod) ||
                other.activeUsersInPeriod == activeUsersInPeriod) &&
            (identical(other.retentionRate, retentionRate) ||
                other.retentionRate == retentionRate) &&
            const DeepCollectionEquality().equals(
              other._monthlyRegistrations,
              _monthlyRegistrations,
            ) &&
            const DeepCollectionEquality().equals(
              other._mostActiveUsers,
              _mostActiveUsers,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    from,
    to,
    totalUsers,
    newUsersInPeriod,
    activeUsersInPeriod,
    retentionRate,
    const DeepCollectionEquality().hash(_monthlyRegistrations),
    const DeepCollectionEquality().hash(_mostActiveUsers),
  );

  /// Create a copy of UserReportModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserReportModelImplCopyWith<_$UserReportModelImpl> get copyWith =>
      __$$UserReportModelImplCopyWithImpl<_$UserReportModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$UserReportModelImplToJson(this);
  }
}

abstract class _UserReportModel implements UserReportModel {
  const factory _UserReportModel({
    required final DateTime from,
    required final DateTime to,
    required final int totalUsers,
    required final int newUsersInPeriod,
    required final int activeUsersInPeriod,
    required final double retentionRate,
    required final List<MonthlyRegistrationItem> monthlyRegistrations,
    required final List<UserActivityItem> mostActiveUsers,
  }) = _$UserReportModelImpl;

  factory _UserReportModel.fromJson(Map<String, dynamic> json) =
      _$UserReportModelImpl.fromJson;

  @override
  DateTime get from;
  @override
  DateTime get to;
  @override
  int get totalUsers;
  @override
  int get newUsersInPeriod;
  @override
  int get activeUsersInPeriod;
  @override
  double get retentionRate;
  @override
  List<MonthlyRegistrationItem> get monthlyRegistrations;
  @override
  List<UserActivityItem> get mostActiveUsers;

  /// Create a copy of UserReportModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserReportModelImplCopyWith<_$UserReportModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MonthlyRegistrationItem _$MonthlyRegistrationItemFromJson(
  Map<String, dynamic> json,
) {
  return _MonthlyRegistrationItem.fromJson(json);
}

/// @nodoc
mixin _$MonthlyRegistrationItem {
  String get month => throw _privateConstructorUsedError;
  int get year => throw _privateConstructorUsedError;
  int get count => throw _privateConstructorUsedError;

  /// Serializes this MonthlyRegistrationItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MonthlyRegistrationItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MonthlyRegistrationItemCopyWith<MonthlyRegistrationItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MonthlyRegistrationItemCopyWith<$Res> {
  factory $MonthlyRegistrationItemCopyWith(
    MonthlyRegistrationItem value,
    $Res Function(MonthlyRegistrationItem) then,
  ) = _$MonthlyRegistrationItemCopyWithImpl<$Res, MonthlyRegistrationItem>;
  @useResult
  $Res call({String month, int year, int count});
}

/// @nodoc
class _$MonthlyRegistrationItemCopyWithImpl<
  $Res,
  $Val extends MonthlyRegistrationItem
>
    implements $MonthlyRegistrationItemCopyWith<$Res> {
  _$MonthlyRegistrationItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MonthlyRegistrationItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? month = null, Object? year = null, Object? count = null}) {
    return _then(
      _value.copyWith(
            month: null == month
                ? _value.month
                : month // ignore: cast_nullable_to_non_nullable
                      as String,
            year: null == year
                ? _value.year
                : year // ignore: cast_nullable_to_non_nullable
                      as int,
            count: null == count
                ? _value.count
                : count // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MonthlyRegistrationItemImplCopyWith<$Res>
    implements $MonthlyRegistrationItemCopyWith<$Res> {
  factory _$$MonthlyRegistrationItemImplCopyWith(
    _$MonthlyRegistrationItemImpl value,
    $Res Function(_$MonthlyRegistrationItemImpl) then,
  ) = __$$MonthlyRegistrationItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String month, int year, int count});
}

/// @nodoc
class __$$MonthlyRegistrationItemImplCopyWithImpl<$Res>
    extends
        _$MonthlyRegistrationItemCopyWithImpl<
          $Res,
          _$MonthlyRegistrationItemImpl
        >
    implements _$$MonthlyRegistrationItemImplCopyWith<$Res> {
  __$$MonthlyRegistrationItemImplCopyWithImpl(
    _$MonthlyRegistrationItemImpl _value,
    $Res Function(_$MonthlyRegistrationItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MonthlyRegistrationItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? month = null, Object? year = null, Object? count = null}) {
    return _then(
      _$MonthlyRegistrationItemImpl(
        month: null == month
            ? _value.month
            : month // ignore: cast_nullable_to_non_nullable
                  as String,
        year: null == year
            ? _value.year
            : year // ignore: cast_nullable_to_non_nullable
                  as int,
        count: null == count
            ? _value.count
            : count // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$MonthlyRegistrationItemImpl implements _MonthlyRegistrationItem {
  const _$MonthlyRegistrationItemImpl({
    required this.month,
    required this.year,
    required this.count,
  });

  factory _$MonthlyRegistrationItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$MonthlyRegistrationItemImplFromJson(json);

  @override
  final String month;
  @override
  final int year;
  @override
  final int count;

  @override
  String toString() {
    return 'MonthlyRegistrationItem(month: $month, year: $year, count: $count)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MonthlyRegistrationItemImpl &&
            (identical(other.month, month) || other.month == month) &&
            (identical(other.year, year) || other.year == year) &&
            (identical(other.count, count) || other.count == count));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, month, year, count);

  /// Create a copy of MonthlyRegistrationItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MonthlyRegistrationItemImplCopyWith<_$MonthlyRegistrationItemImpl>
  get copyWith =>
      __$$MonthlyRegistrationItemImplCopyWithImpl<
        _$MonthlyRegistrationItemImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MonthlyRegistrationItemImplToJson(this);
  }
}

abstract class _MonthlyRegistrationItem implements MonthlyRegistrationItem {
  const factory _MonthlyRegistrationItem({
    required final String month,
    required final int year,
    required final int count,
  }) = _$MonthlyRegistrationItemImpl;

  factory _MonthlyRegistrationItem.fromJson(Map<String, dynamic> json) =
      _$MonthlyRegistrationItemImpl.fromJson;

  @override
  String get month;
  @override
  int get year;
  @override
  int get count;

  /// Create a copy of MonthlyRegistrationItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MonthlyRegistrationItemImplCopyWith<_$MonthlyRegistrationItemImpl>
  get copyWith => throw _privateConstructorUsedError;
}

UserActivityItem _$UserActivityItemFromJson(Map<String, dynamic> json) {
  return _UserActivityItem.fromJson(json);
}

/// @nodoc
mixin _$UserActivityItem {
  String get fullName => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  int get gymVisits => throw _privateConstructorUsedError;
  int get totalMinutes => throw _privateConstructorUsedError;

  /// Serializes this UserActivityItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserActivityItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserActivityItemCopyWith<UserActivityItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserActivityItemCopyWith<$Res> {
  factory $UserActivityItemCopyWith(
    UserActivityItem value,
    $Res Function(UserActivityItem) then,
  ) = _$UserActivityItemCopyWithImpl<$Res, UserActivityItem>;
  @useResult
  $Res call({String fullName, String email, int gymVisits, int totalMinutes});
}

/// @nodoc
class _$UserActivityItemCopyWithImpl<$Res, $Val extends UserActivityItem>
    implements $UserActivityItemCopyWith<$Res> {
  _$UserActivityItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserActivityItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fullName = null,
    Object? email = null,
    Object? gymVisits = null,
    Object? totalMinutes = null,
  }) {
    return _then(
      _value.copyWith(
            fullName: null == fullName
                ? _value.fullName
                : fullName // ignore: cast_nullable_to_non_nullable
                      as String,
            email: null == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as String,
            gymVisits: null == gymVisits
                ? _value.gymVisits
                : gymVisits // ignore: cast_nullable_to_non_nullable
                      as int,
            totalMinutes: null == totalMinutes
                ? _value.totalMinutes
                : totalMinutes // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UserActivityItemImplCopyWith<$Res>
    implements $UserActivityItemCopyWith<$Res> {
  factory _$$UserActivityItemImplCopyWith(
    _$UserActivityItemImpl value,
    $Res Function(_$UserActivityItemImpl) then,
  ) = __$$UserActivityItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String fullName, String email, int gymVisits, int totalMinutes});
}

/// @nodoc
class __$$UserActivityItemImplCopyWithImpl<$Res>
    extends _$UserActivityItemCopyWithImpl<$Res, _$UserActivityItemImpl>
    implements _$$UserActivityItemImplCopyWith<$Res> {
  __$$UserActivityItemImplCopyWithImpl(
    _$UserActivityItemImpl _value,
    $Res Function(_$UserActivityItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserActivityItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fullName = null,
    Object? email = null,
    Object? gymVisits = null,
    Object? totalMinutes = null,
  }) {
    return _then(
      _$UserActivityItemImpl(
        fullName: null == fullName
            ? _value.fullName
            : fullName // ignore: cast_nullable_to_non_nullable
                  as String,
        email: null == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String,
        gymVisits: null == gymVisits
            ? _value.gymVisits
            : gymVisits // ignore: cast_nullable_to_non_nullable
                  as int,
        totalMinutes: null == totalMinutes
            ? _value.totalMinutes
            : totalMinutes // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UserActivityItemImpl implements _UserActivityItem {
  const _$UserActivityItemImpl({
    required this.fullName,
    required this.email,
    required this.gymVisits,
    required this.totalMinutes,
  });

  factory _$UserActivityItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserActivityItemImplFromJson(json);

  @override
  final String fullName;
  @override
  final String email;
  @override
  final int gymVisits;
  @override
  final int totalMinutes;

  @override
  String toString() {
    return 'UserActivityItem(fullName: $fullName, email: $email, gymVisits: $gymVisits, totalMinutes: $totalMinutes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserActivityItemImpl &&
            (identical(other.fullName, fullName) ||
                other.fullName == fullName) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.gymVisits, gymVisits) ||
                other.gymVisits == gymVisits) &&
            (identical(other.totalMinutes, totalMinutes) ||
                other.totalMinutes == totalMinutes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, fullName, email, gymVisits, totalMinutes);

  /// Create a copy of UserActivityItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserActivityItemImplCopyWith<_$UserActivityItemImpl> get copyWith =>
      __$$UserActivityItemImplCopyWithImpl<_$UserActivityItemImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$UserActivityItemImplToJson(this);
  }
}

abstract class _UserActivityItem implements UserActivityItem {
  const factory _UserActivityItem({
    required final String fullName,
    required final String email,
    required final int gymVisits,
    required final int totalMinutes,
  }) = _$UserActivityItemImpl;

  factory _UserActivityItem.fromJson(Map<String, dynamic> json) =
      _$UserActivityItemImpl.fromJson;

  @override
  String get fullName;
  @override
  String get email;
  @override
  int get gymVisits;
  @override
  int get totalMinutes;

  /// Create a copy of UserActivityItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserActivityItemImplCopyWith<_$UserActivityItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
