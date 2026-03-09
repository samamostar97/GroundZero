// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'activity_feed_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ActivityFeedItem _$ActivityFeedItemFromJson(Map<String, dynamic> json) {
  return _ActivityFeedItem.fromJson(json);
}

/// @nodoc
mixin _$ActivityFeedItem {
  String get type => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;

  /// Serializes this ActivityFeedItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ActivityFeedItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ActivityFeedItemCopyWith<ActivityFeedItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ActivityFeedItemCopyWith<$Res> {
  factory $ActivityFeedItemCopyWith(
    ActivityFeedItem value,
    $Res Function(ActivityFeedItem) then,
  ) = _$ActivityFeedItemCopyWithImpl<$Res, ActivityFeedItem>;
  @useResult
  $Res call({String type, String message, DateTime timestamp});
}

/// @nodoc
class _$ActivityFeedItemCopyWithImpl<$Res, $Val extends ActivityFeedItem>
    implements $ActivityFeedItemCopyWith<$Res> {
  _$ActivityFeedItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ActivityFeedItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? message = null,
    Object? timestamp = null,
  }) {
    return _then(
      _value.copyWith(
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as String,
            message: null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String,
            timestamp: null == timestamp
                ? _value.timestamp
                : timestamp // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ActivityFeedItemImplCopyWith<$Res>
    implements $ActivityFeedItemCopyWith<$Res> {
  factory _$$ActivityFeedItemImplCopyWith(
    _$ActivityFeedItemImpl value,
    $Res Function(_$ActivityFeedItemImpl) then,
  ) = __$$ActivityFeedItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String type, String message, DateTime timestamp});
}

/// @nodoc
class __$$ActivityFeedItemImplCopyWithImpl<$Res>
    extends _$ActivityFeedItemCopyWithImpl<$Res, _$ActivityFeedItemImpl>
    implements _$$ActivityFeedItemImplCopyWith<$Res> {
  __$$ActivityFeedItemImplCopyWithImpl(
    _$ActivityFeedItemImpl _value,
    $Res Function(_$ActivityFeedItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ActivityFeedItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? message = null,
    Object? timestamp = null,
  }) {
    return _then(
      _$ActivityFeedItemImpl(
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String,
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        timestamp: null == timestamp
            ? _value.timestamp
            : timestamp // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ActivityFeedItemImpl implements _ActivityFeedItem {
  const _$ActivityFeedItemImpl({
    required this.type,
    required this.message,
    required this.timestamp,
  });

  factory _$ActivityFeedItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$ActivityFeedItemImplFromJson(json);

  @override
  final String type;
  @override
  final String message;
  @override
  final DateTime timestamp;

  @override
  String toString() {
    return 'ActivityFeedItem(type: $type, message: $message, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ActivityFeedItemImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, type, message, timestamp);

  /// Create a copy of ActivityFeedItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ActivityFeedItemImplCopyWith<_$ActivityFeedItemImpl> get copyWith =>
      __$$ActivityFeedItemImplCopyWithImpl<_$ActivityFeedItemImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ActivityFeedItemImplToJson(this);
  }
}

abstract class _ActivityFeedItem implements ActivityFeedItem {
  const factory _ActivityFeedItem({
    required final String type,
    required final String message,
    required final DateTime timestamp,
  }) = _$ActivityFeedItemImpl;

  factory _ActivityFeedItem.fromJson(Map<String, dynamic> json) =
      _$ActivityFeedItemImpl.fromJson;

  @override
  String get type;
  @override
  String get message;
  @override
  DateTime get timestamp;

  /// Create a copy of ActivityFeedItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ActivityFeedItemImplCopyWith<_$ActivityFeedItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
