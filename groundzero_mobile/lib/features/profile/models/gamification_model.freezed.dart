// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'gamification_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

GamificationModel _$GamificationModelFromJson(Map<String, dynamic> json) {
  return _GamificationModel.fromJson(json);
}

/// @nodoc
mixin _$GamificationModel {
  int get xp => throw _privateConstructorUsedError;
  int get level => throw _privateConstructorUsedError;
  String get levelName => throw _privateConstructorUsedError;
  int get totalGymMinutes => throw _privateConstructorUsedError;
  int get rank => throw _privateConstructorUsedError;
  int? get nextLevelXP => throw _privateConstructorUsedError;

  /// Serializes this GamificationModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GamificationModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GamificationModelCopyWith<GamificationModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GamificationModelCopyWith<$Res> {
  factory $GamificationModelCopyWith(
    GamificationModel value,
    $Res Function(GamificationModel) then,
  ) = _$GamificationModelCopyWithImpl<$Res, GamificationModel>;
  @useResult
  $Res call({
    int xp,
    int level,
    String levelName,
    int totalGymMinutes,
    int rank,
    int? nextLevelXP,
  });
}

/// @nodoc
class _$GamificationModelCopyWithImpl<$Res, $Val extends GamificationModel>
    implements $GamificationModelCopyWith<$Res> {
  _$GamificationModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GamificationModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? xp = null,
    Object? level = null,
    Object? levelName = null,
    Object? totalGymMinutes = null,
    Object? rank = null,
    Object? nextLevelXP = freezed,
  }) {
    return _then(
      _value.copyWith(
            xp: null == xp
                ? _value.xp
                : xp // ignore: cast_nullable_to_non_nullable
                      as int,
            level: null == level
                ? _value.level
                : level // ignore: cast_nullable_to_non_nullable
                      as int,
            levelName: null == levelName
                ? _value.levelName
                : levelName // ignore: cast_nullable_to_non_nullable
                      as String,
            totalGymMinutes: null == totalGymMinutes
                ? _value.totalGymMinutes
                : totalGymMinutes // ignore: cast_nullable_to_non_nullable
                      as int,
            rank: null == rank
                ? _value.rank
                : rank // ignore: cast_nullable_to_non_nullable
                      as int,
            nextLevelXP: freezed == nextLevelXP
                ? _value.nextLevelXP
                : nextLevelXP // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$GamificationModelImplCopyWith<$Res>
    implements $GamificationModelCopyWith<$Res> {
  factory _$$GamificationModelImplCopyWith(
    _$GamificationModelImpl value,
    $Res Function(_$GamificationModelImpl) then,
  ) = __$$GamificationModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int xp,
    int level,
    String levelName,
    int totalGymMinutes,
    int rank,
    int? nextLevelXP,
  });
}

/// @nodoc
class __$$GamificationModelImplCopyWithImpl<$Res>
    extends _$GamificationModelCopyWithImpl<$Res, _$GamificationModelImpl>
    implements _$$GamificationModelImplCopyWith<$Res> {
  __$$GamificationModelImplCopyWithImpl(
    _$GamificationModelImpl _value,
    $Res Function(_$GamificationModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GamificationModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? xp = null,
    Object? level = null,
    Object? levelName = null,
    Object? totalGymMinutes = null,
    Object? rank = null,
    Object? nextLevelXP = freezed,
  }) {
    return _then(
      _$GamificationModelImpl(
        xp: null == xp
            ? _value.xp
            : xp // ignore: cast_nullable_to_non_nullable
                  as int,
        level: null == level
            ? _value.level
            : level // ignore: cast_nullable_to_non_nullable
                  as int,
        levelName: null == levelName
            ? _value.levelName
            : levelName // ignore: cast_nullable_to_non_nullable
                  as String,
        totalGymMinutes: null == totalGymMinutes
            ? _value.totalGymMinutes
            : totalGymMinutes // ignore: cast_nullable_to_non_nullable
                  as int,
        rank: null == rank
            ? _value.rank
            : rank // ignore: cast_nullable_to_non_nullable
                  as int,
        nextLevelXP: freezed == nextLevelXP
            ? _value.nextLevelXP
            : nextLevelXP // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$GamificationModelImpl implements _GamificationModel {
  const _$GamificationModelImpl({
    required this.xp,
    required this.level,
    required this.levelName,
    required this.totalGymMinutes,
    required this.rank,
    this.nextLevelXP,
  });

  factory _$GamificationModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$GamificationModelImplFromJson(json);

  @override
  final int xp;
  @override
  final int level;
  @override
  final String levelName;
  @override
  final int totalGymMinutes;
  @override
  final int rank;
  @override
  final int? nextLevelXP;

  @override
  String toString() {
    return 'GamificationModel(xp: $xp, level: $level, levelName: $levelName, totalGymMinutes: $totalGymMinutes, rank: $rank, nextLevelXP: $nextLevelXP)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GamificationModelImpl &&
            (identical(other.xp, xp) || other.xp == xp) &&
            (identical(other.level, level) || other.level == level) &&
            (identical(other.levelName, levelName) ||
                other.levelName == levelName) &&
            (identical(other.totalGymMinutes, totalGymMinutes) ||
                other.totalGymMinutes == totalGymMinutes) &&
            (identical(other.rank, rank) || other.rank == rank) &&
            (identical(other.nextLevelXP, nextLevelXP) ||
                other.nextLevelXP == nextLevelXP));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    xp,
    level,
    levelName,
    totalGymMinutes,
    rank,
    nextLevelXP,
  );

  /// Create a copy of GamificationModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GamificationModelImplCopyWith<_$GamificationModelImpl> get copyWith =>
      __$$GamificationModelImplCopyWithImpl<_$GamificationModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$GamificationModelImplToJson(this);
  }
}

abstract class _GamificationModel implements GamificationModel {
  const factory _GamificationModel({
    required final int xp,
    required final int level,
    required final String levelName,
    required final int totalGymMinutes,
    required final int rank,
    final int? nextLevelXP,
  }) = _$GamificationModelImpl;

  factory _GamificationModel.fromJson(Map<String, dynamic> json) =
      _$GamificationModelImpl.fromJson;

  @override
  int get xp;
  @override
  int get level;
  @override
  String get levelName;
  @override
  int get totalGymMinutes;
  @override
  int get rank;
  @override
  int? get nextLevelXP;

  /// Create a copy of GamificationModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GamificationModelImplCopyWith<_$GamificationModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
