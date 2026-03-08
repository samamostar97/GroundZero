// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'gamification_report_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

GamificationReportModel _$GamificationReportModelFromJson(
  Map<String, dynamic> json,
) {
  return _GamificationReportModel.fromJson(json);
}

/// @nodoc
mixin _$GamificationReportModel {
  DateTime get from => throw _privateConstructorUsedError;
  DateTime get to => throw _privateConstructorUsedError;
  int get totalGymVisits => throw _privateConstructorUsedError;
  double get avgVisitDurationMinutes => throw _privateConstructorUsedError;
  List<LevelDistributionItem> get levelDistribution =>
      throw _privateConstructorUsedError;
  List<LeaderboardSummaryItem> get topUsers =>
      throw _privateConstructorUsedError;
  List<DailyVisitItem> get dailyVisits => throw _privateConstructorUsedError;

  /// Serializes this GamificationReportModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GamificationReportModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GamificationReportModelCopyWith<GamificationReportModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GamificationReportModelCopyWith<$Res> {
  factory $GamificationReportModelCopyWith(
    GamificationReportModel value,
    $Res Function(GamificationReportModel) then,
  ) = _$GamificationReportModelCopyWithImpl<$Res, GamificationReportModel>;
  @useResult
  $Res call({
    DateTime from,
    DateTime to,
    int totalGymVisits,
    double avgVisitDurationMinutes,
    List<LevelDistributionItem> levelDistribution,
    List<LeaderboardSummaryItem> topUsers,
    List<DailyVisitItem> dailyVisits,
  });
}

/// @nodoc
class _$GamificationReportModelCopyWithImpl<
  $Res,
  $Val extends GamificationReportModel
>
    implements $GamificationReportModelCopyWith<$Res> {
  _$GamificationReportModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GamificationReportModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? from = null,
    Object? to = null,
    Object? totalGymVisits = null,
    Object? avgVisitDurationMinutes = null,
    Object? levelDistribution = null,
    Object? topUsers = null,
    Object? dailyVisits = null,
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
            totalGymVisits: null == totalGymVisits
                ? _value.totalGymVisits
                : totalGymVisits // ignore: cast_nullable_to_non_nullable
                      as int,
            avgVisitDurationMinutes: null == avgVisitDurationMinutes
                ? _value.avgVisitDurationMinutes
                : avgVisitDurationMinutes // ignore: cast_nullable_to_non_nullable
                      as double,
            levelDistribution: null == levelDistribution
                ? _value.levelDistribution
                : levelDistribution // ignore: cast_nullable_to_non_nullable
                      as List<LevelDistributionItem>,
            topUsers: null == topUsers
                ? _value.topUsers
                : topUsers // ignore: cast_nullable_to_non_nullable
                      as List<LeaderboardSummaryItem>,
            dailyVisits: null == dailyVisits
                ? _value.dailyVisits
                : dailyVisits // ignore: cast_nullable_to_non_nullable
                      as List<DailyVisitItem>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$GamificationReportModelImplCopyWith<$Res>
    implements $GamificationReportModelCopyWith<$Res> {
  factory _$$GamificationReportModelImplCopyWith(
    _$GamificationReportModelImpl value,
    $Res Function(_$GamificationReportModelImpl) then,
  ) = __$$GamificationReportModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    DateTime from,
    DateTime to,
    int totalGymVisits,
    double avgVisitDurationMinutes,
    List<LevelDistributionItem> levelDistribution,
    List<LeaderboardSummaryItem> topUsers,
    List<DailyVisitItem> dailyVisits,
  });
}

/// @nodoc
class __$$GamificationReportModelImplCopyWithImpl<$Res>
    extends
        _$GamificationReportModelCopyWithImpl<
          $Res,
          _$GamificationReportModelImpl
        >
    implements _$$GamificationReportModelImplCopyWith<$Res> {
  __$$GamificationReportModelImplCopyWithImpl(
    _$GamificationReportModelImpl _value,
    $Res Function(_$GamificationReportModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GamificationReportModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? from = null,
    Object? to = null,
    Object? totalGymVisits = null,
    Object? avgVisitDurationMinutes = null,
    Object? levelDistribution = null,
    Object? topUsers = null,
    Object? dailyVisits = null,
  }) {
    return _then(
      _$GamificationReportModelImpl(
        from: null == from
            ? _value.from
            : from // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        to: null == to
            ? _value.to
            : to // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        totalGymVisits: null == totalGymVisits
            ? _value.totalGymVisits
            : totalGymVisits // ignore: cast_nullable_to_non_nullable
                  as int,
        avgVisitDurationMinutes: null == avgVisitDurationMinutes
            ? _value.avgVisitDurationMinutes
            : avgVisitDurationMinutes // ignore: cast_nullable_to_non_nullable
                  as double,
        levelDistribution: null == levelDistribution
            ? _value._levelDistribution
            : levelDistribution // ignore: cast_nullable_to_non_nullable
                  as List<LevelDistributionItem>,
        topUsers: null == topUsers
            ? _value._topUsers
            : topUsers // ignore: cast_nullable_to_non_nullable
                  as List<LeaderboardSummaryItem>,
        dailyVisits: null == dailyVisits
            ? _value._dailyVisits
            : dailyVisits // ignore: cast_nullable_to_non_nullable
                  as List<DailyVisitItem>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$GamificationReportModelImpl implements _GamificationReportModel {
  const _$GamificationReportModelImpl({
    required this.from,
    required this.to,
    required this.totalGymVisits,
    required this.avgVisitDurationMinutes,
    required final List<LevelDistributionItem> levelDistribution,
    required final List<LeaderboardSummaryItem> topUsers,
    required final List<DailyVisitItem> dailyVisits,
  }) : _levelDistribution = levelDistribution,
       _topUsers = topUsers,
       _dailyVisits = dailyVisits;

  factory _$GamificationReportModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$GamificationReportModelImplFromJson(json);

  @override
  final DateTime from;
  @override
  final DateTime to;
  @override
  final int totalGymVisits;
  @override
  final double avgVisitDurationMinutes;
  final List<LevelDistributionItem> _levelDistribution;
  @override
  List<LevelDistributionItem> get levelDistribution {
    if (_levelDistribution is EqualUnmodifiableListView)
      return _levelDistribution;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_levelDistribution);
  }

  final List<LeaderboardSummaryItem> _topUsers;
  @override
  List<LeaderboardSummaryItem> get topUsers {
    if (_topUsers is EqualUnmodifiableListView) return _topUsers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_topUsers);
  }

  final List<DailyVisitItem> _dailyVisits;
  @override
  List<DailyVisitItem> get dailyVisits {
    if (_dailyVisits is EqualUnmodifiableListView) return _dailyVisits;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_dailyVisits);
  }

  @override
  String toString() {
    return 'GamificationReportModel(from: $from, to: $to, totalGymVisits: $totalGymVisits, avgVisitDurationMinutes: $avgVisitDurationMinutes, levelDistribution: $levelDistribution, topUsers: $topUsers, dailyVisits: $dailyVisits)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GamificationReportModelImpl &&
            (identical(other.from, from) || other.from == from) &&
            (identical(other.to, to) || other.to == to) &&
            (identical(other.totalGymVisits, totalGymVisits) ||
                other.totalGymVisits == totalGymVisits) &&
            (identical(
                  other.avgVisitDurationMinutes,
                  avgVisitDurationMinutes,
                ) ||
                other.avgVisitDurationMinutes == avgVisitDurationMinutes) &&
            const DeepCollectionEquality().equals(
              other._levelDistribution,
              _levelDistribution,
            ) &&
            const DeepCollectionEquality().equals(other._topUsers, _topUsers) &&
            const DeepCollectionEquality().equals(
              other._dailyVisits,
              _dailyVisits,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    from,
    to,
    totalGymVisits,
    avgVisitDurationMinutes,
    const DeepCollectionEquality().hash(_levelDistribution),
    const DeepCollectionEquality().hash(_topUsers),
    const DeepCollectionEquality().hash(_dailyVisits),
  );

  /// Create a copy of GamificationReportModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GamificationReportModelImplCopyWith<_$GamificationReportModelImpl>
  get copyWith =>
      __$$GamificationReportModelImplCopyWithImpl<
        _$GamificationReportModelImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GamificationReportModelImplToJson(this);
  }
}

abstract class _GamificationReportModel implements GamificationReportModel {
  const factory _GamificationReportModel({
    required final DateTime from,
    required final DateTime to,
    required final int totalGymVisits,
    required final double avgVisitDurationMinutes,
    required final List<LevelDistributionItem> levelDistribution,
    required final List<LeaderboardSummaryItem> topUsers,
    required final List<DailyVisitItem> dailyVisits,
  }) = _$GamificationReportModelImpl;

  factory _GamificationReportModel.fromJson(Map<String, dynamic> json) =
      _$GamificationReportModelImpl.fromJson;

  @override
  DateTime get from;
  @override
  DateTime get to;
  @override
  int get totalGymVisits;
  @override
  double get avgVisitDurationMinutes;
  @override
  List<LevelDistributionItem> get levelDistribution;
  @override
  List<LeaderboardSummaryItem> get topUsers;
  @override
  List<DailyVisitItem> get dailyVisits;

  /// Create a copy of GamificationReportModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GamificationReportModelImplCopyWith<_$GamificationReportModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}

LevelDistributionItem _$LevelDistributionItemFromJson(
  Map<String, dynamic> json,
) {
  return _LevelDistributionItem.fromJson(json);
}

/// @nodoc
mixin _$LevelDistributionItem {
  String get levelName => throw _privateConstructorUsedError;
  int get userCount => throw _privateConstructorUsedError;

  /// Serializes this LevelDistributionItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LevelDistributionItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LevelDistributionItemCopyWith<LevelDistributionItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LevelDistributionItemCopyWith<$Res> {
  factory $LevelDistributionItemCopyWith(
    LevelDistributionItem value,
    $Res Function(LevelDistributionItem) then,
  ) = _$LevelDistributionItemCopyWithImpl<$Res, LevelDistributionItem>;
  @useResult
  $Res call({String levelName, int userCount});
}

/// @nodoc
class _$LevelDistributionItemCopyWithImpl<
  $Res,
  $Val extends LevelDistributionItem
>
    implements $LevelDistributionItemCopyWith<$Res> {
  _$LevelDistributionItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LevelDistributionItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? levelName = null, Object? userCount = null}) {
    return _then(
      _value.copyWith(
            levelName: null == levelName
                ? _value.levelName
                : levelName // ignore: cast_nullable_to_non_nullable
                      as String,
            userCount: null == userCount
                ? _value.userCount
                : userCount // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$LevelDistributionItemImplCopyWith<$Res>
    implements $LevelDistributionItemCopyWith<$Res> {
  factory _$$LevelDistributionItemImplCopyWith(
    _$LevelDistributionItemImpl value,
    $Res Function(_$LevelDistributionItemImpl) then,
  ) = __$$LevelDistributionItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String levelName, int userCount});
}

/// @nodoc
class __$$LevelDistributionItemImplCopyWithImpl<$Res>
    extends
        _$LevelDistributionItemCopyWithImpl<$Res, _$LevelDistributionItemImpl>
    implements _$$LevelDistributionItemImplCopyWith<$Res> {
  __$$LevelDistributionItemImplCopyWithImpl(
    _$LevelDistributionItemImpl _value,
    $Res Function(_$LevelDistributionItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LevelDistributionItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? levelName = null, Object? userCount = null}) {
    return _then(
      _$LevelDistributionItemImpl(
        levelName: null == levelName
            ? _value.levelName
            : levelName // ignore: cast_nullable_to_non_nullable
                  as String,
        userCount: null == userCount
            ? _value.userCount
            : userCount // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$LevelDistributionItemImpl implements _LevelDistributionItem {
  const _$LevelDistributionItemImpl({
    required this.levelName,
    required this.userCount,
  });

  factory _$LevelDistributionItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$LevelDistributionItemImplFromJson(json);

  @override
  final String levelName;
  @override
  final int userCount;

  @override
  String toString() {
    return 'LevelDistributionItem(levelName: $levelName, userCount: $userCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LevelDistributionItemImpl &&
            (identical(other.levelName, levelName) ||
                other.levelName == levelName) &&
            (identical(other.userCount, userCount) ||
                other.userCount == userCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, levelName, userCount);

  /// Create a copy of LevelDistributionItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LevelDistributionItemImplCopyWith<_$LevelDistributionItemImpl>
  get copyWith =>
      __$$LevelDistributionItemImplCopyWithImpl<_$LevelDistributionItemImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$LevelDistributionItemImplToJson(this);
  }
}

abstract class _LevelDistributionItem implements LevelDistributionItem {
  const factory _LevelDistributionItem({
    required final String levelName,
    required final int userCount,
  }) = _$LevelDistributionItemImpl;

  factory _LevelDistributionItem.fromJson(Map<String, dynamic> json) =
      _$LevelDistributionItemImpl.fromJson;

  @override
  String get levelName;
  @override
  int get userCount;

  /// Create a copy of LevelDistributionItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LevelDistributionItemImplCopyWith<_$LevelDistributionItemImpl>
  get copyWith => throw _privateConstructorUsedError;
}

LeaderboardSummaryItem _$LeaderboardSummaryItemFromJson(
  Map<String, dynamic> json,
) {
  return _LeaderboardSummaryItem.fromJson(json);
}

/// @nodoc
mixin _$LeaderboardSummaryItem {
  String get fullName => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  int get level => throw _privateConstructorUsedError;
  int get xp => throw _privateConstructorUsedError;
  int get totalGymMinutes => throw _privateConstructorUsedError;

  /// Serializes this LeaderboardSummaryItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LeaderboardSummaryItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LeaderboardSummaryItemCopyWith<LeaderboardSummaryItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LeaderboardSummaryItemCopyWith<$Res> {
  factory $LeaderboardSummaryItemCopyWith(
    LeaderboardSummaryItem value,
    $Res Function(LeaderboardSummaryItem) then,
  ) = _$LeaderboardSummaryItemCopyWithImpl<$Res, LeaderboardSummaryItem>;
  @useResult
  $Res call({
    String fullName,
    String email,
    int level,
    int xp,
    int totalGymMinutes,
  });
}

/// @nodoc
class _$LeaderboardSummaryItemCopyWithImpl<
  $Res,
  $Val extends LeaderboardSummaryItem
>
    implements $LeaderboardSummaryItemCopyWith<$Res> {
  _$LeaderboardSummaryItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LeaderboardSummaryItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fullName = null,
    Object? email = null,
    Object? level = null,
    Object? xp = null,
    Object? totalGymMinutes = null,
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
            level: null == level
                ? _value.level
                : level // ignore: cast_nullable_to_non_nullable
                      as int,
            xp: null == xp
                ? _value.xp
                : xp // ignore: cast_nullable_to_non_nullable
                      as int,
            totalGymMinutes: null == totalGymMinutes
                ? _value.totalGymMinutes
                : totalGymMinutes // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$LeaderboardSummaryItemImplCopyWith<$Res>
    implements $LeaderboardSummaryItemCopyWith<$Res> {
  factory _$$LeaderboardSummaryItemImplCopyWith(
    _$LeaderboardSummaryItemImpl value,
    $Res Function(_$LeaderboardSummaryItemImpl) then,
  ) = __$$LeaderboardSummaryItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String fullName,
    String email,
    int level,
    int xp,
    int totalGymMinutes,
  });
}

/// @nodoc
class __$$LeaderboardSummaryItemImplCopyWithImpl<$Res>
    extends
        _$LeaderboardSummaryItemCopyWithImpl<$Res, _$LeaderboardSummaryItemImpl>
    implements _$$LeaderboardSummaryItemImplCopyWith<$Res> {
  __$$LeaderboardSummaryItemImplCopyWithImpl(
    _$LeaderboardSummaryItemImpl _value,
    $Res Function(_$LeaderboardSummaryItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LeaderboardSummaryItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fullName = null,
    Object? email = null,
    Object? level = null,
    Object? xp = null,
    Object? totalGymMinutes = null,
  }) {
    return _then(
      _$LeaderboardSummaryItemImpl(
        fullName: null == fullName
            ? _value.fullName
            : fullName // ignore: cast_nullable_to_non_nullable
                  as String,
        email: null == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String,
        level: null == level
            ? _value.level
            : level // ignore: cast_nullable_to_non_nullable
                  as int,
        xp: null == xp
            ? _value.xp
            : xp // ignore: cast_nullable_to_non_nullable
                  as int,
        totalGymMinutes: null == totalGymMinutes
            ? _value.totalGymMinutes
            : totalGymMinutes // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$LeaderboardSummaryItemImpl implements _LeaderboardSummaryItem {
  const _$LeaderboardSummaryItemImpl({
    required this.fullName,
    required this.email,
    required this.level,
    required this.xp,
    required this.totalGymMinutes,
  });

  factory _$LeaderboardSummaryItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$LeaderboardSummaryItemImplFromJson(json);

  @override
  final String fullName;
  @override
  final String email;
  @override
  final int level;
  @override
  final int xp;
  @override
  final int totalGymMinutes;

  @override
  String toString() {
    return 'LeaderboardSummaryItem(fullName: $fullName, email: $email, level: $level, xp: $xp, totalGymMinutes: $totalGymMinutes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LeaderboardSummaryItemImpl &&
            (identical(other.fullName, fullName) ||
                other.fullName == fullName) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.level, level) || other.level == level) &&
            (identical(other.xp, xp) || other.xp == xp) &&
            (identical(other.totalGymMinutes, totalGymMinutes) ||
                other.totalGymMinutes == totalGymMinutes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, fullName, email, level, xp, totalGymMinutes);

  /// Create a copy of LeaderboardSummaryItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LeaderboardSummaryItemImplCopyWith<_$LeaderboardSummaryItemImpl>
  get copyWith =>
      __$$LeaderboardSummaryItemImplCopyWithImpl<_$LeaderboardSummaryItemImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$LeaderboardSummaryItemImplToJson(this);
  }
}

abstract class _LeaderboardSummaryItem implements LeaderboardSummaryItem {
  const factory _LeaderboardSummaryItem({
    required final String fullName,
    required final String email,
    required final int level,
    required final int xp,
    required final int totalGymMinutes,
  }) = _$LeaderboardSummaryItemImpl;

  factory _LeaderboardSummaryItem.fromJson(Map<String, dynamic> json) =
      _$LeaderboardSummaryItemImpl.fromJson;

  @override
  String get fullName;
  @override
  String get email;
  @override
  int get level;
  @override
  int get xp;
  @override
  int get totalGymMinutes;

  /// Create a copy of LeaderboardSummaryItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LeaderboardSummaryItemImplCopyWith<_$LeaderboardSummaryItemImpl>
  get copyWith => throw _privateConstructorUsedError;
}

DailyVisitItem _$DailyVisitItemFromJson(Map<String, dynamic> json) {
  return _DailyVisitItem.fromJson(json);
}

/// @nodoc
mixin _$DailyVisitItem {
  DateTime get date => throw _privateConstructorUsedError;
  int get visitCount => throw _privateConstructorUsedError;
  double get avgDurationMinutes => throw _privateConstructorUsedError;

  /// Serializes this DailyVisitItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DailyVisitItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DailyVisitItemCopyWith<DailyVisitItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DailyVisitItemCopyWith<$Res> {
  factory $DailyVisitItemCopyWith(
    DailyVisitItem value,
    $Res Function(DailyVisitItem) then,
  ) = _$DailyVisitItemCopyWithImpl<$Res, DailyVisitItem>;
  @useResult
  $Res call({DateTime date, int visitCount, double avgDurationMinutes});
}

/// @nodoc
class _$DailyVisitItemCopyWithImpl<$Res, $Val extends DailyVisitItem>
    implements $DailyVisitItemCopyWith<$Res> {
  _$DailyVisitItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DailyVisitItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? visitCount = null,
    Object? avgDurationMinutes = null,
  }) {
    return _then(
      _value.copyWith(
            date: null == date
                ? _value.date
                : date // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            visitCount: null == visitCount
                ? _value.visitCount
                : visitCount // ignore: cast_nullable_to_non_nullable
                      as int,
            avgDurationMinutes: null == avgDurationMinutes
                ? _value.avgDurationMinutes
                : avgDurationMinutes // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DailyVisitItemImplCopyWith<$Res>
    implements $DailyVisitItemCopyWith<$Res> {
  factory _$$DailyVisitItemImplCopyWith(
    _$DailyVisitItemImpl value,
    $Res Function(_$DailyVisitItemImpl) then,
  ) = __$$DailyVisitItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({DateTime date, int visitCount, double avgDurationMinutes});
}

/// @nodoc
class __$$DailyVisitItemImplCopyWithImpl<$Res>
    extends _$DailyVisitItemCopyWithImpl<$Res, _$DailyVisitItemImpl>
    implements _$$DailyVisitItemImplCopyWith<$Res> {
  __$$DailyVisitItemImplCopyWithImpl(
    _$DailyVisitItemImpl _value,
    $Res Function(_$DailyVisitItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DailyVisitItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? visitCount = null,
    Object? avgDurationMinutes = null,
  }) {
    return _then(
      _$DailyVisitItemImpl(
        date: null == date
            ? _value.date
            : date // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        visitCount: null == visitCount
            ? _value.visitCount
            : visitCount // ignore: cast_nullable_to_non_nullable
                  as int,
        avgDurationMinutes: null == avgDurationMinutes
            ? _value.avgDurationMinutes
            : avgDurationMinutes // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DailyVisitItemImpl implements _DailyVisitItem {
  const _$DailyVisitItemImpl({
    required this.date,
    required this.visitCount,
    required this.avgDurationMinutes,
  });

  factory _$DailyVisitItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$DailyVisitItemImplFromJson(json);

  @override
  final DateTime date;
  @override
  final int visitCount;
  @override
  final double avgDurationMinutes;

  @override
  String toString() {
    return 'DailyVisitItem(date: $date, visitCount: $visitCount, avgDurationMinutes: $avgDurationMinutes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DailyVisitItemImpl &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.visitCount, visitCount) ||
                other.visitCount == visitCount) &&
            (identical(other.avgDurationMinutes, avgDurationMinutes) ||
                other.avgDurationMinutes == avgDurationMinutes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, date, visitCount, avgDurationMinutes);

  /// Create a copy of DailyVisitItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DailyVisitItemImplCopyWith<_$DailyVisitItemImpl> get copyWith =>
      __$$DailyVisitItemImplCopyWithImpl<_$DailyVisitItemImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$DailyVisitItemImplToJson(this);
  }
}

abstract class _DailyVisitItem implements DailyVisitItem {
  const factory _DailyVisitItem({
    required final DateTime date,
    required final int visitCount,
    required final double avgDurationMinutes,
  }) = _$DailyVisitItemImpl;

  factory _DailyVisitItem.fromJson(Map<String, dynamic> json) =
      _$DailyVisitItemImpl.fromJson;

  @override
  DateTime get date;
  @override
  int get visitCount;
  @override
  double get avgDurationMinutes;

  /// Create a copy of DailyVisitItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DailyVisitItemImplCopyWith<_$DailyVisitItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
