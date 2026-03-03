// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'update_review_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

UpdateReviewRequest _$UpdateReviewRequestFromJson(Map<String, dynamic> json) {
  return _UpdateReviewRequest.fromJson(json);
}

/// @nodoc
mixin _$UpdateReviewRequest {
  int get rating => throw _privateConstructorUsedError;
  String? get comment => throw _privateConstructorUsedError;

  /// Serializes this UpdateReviewRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UpdateReviewRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UpdateReviewRequestCopyWith<UpdateReviewRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpdateReviewRequestCopyWith<$Res> {
  factory $UpdateReviewRequestCopyWith(
    UpdateReviewRequest value,
    $Res Function(UpdateReviewRequest) then,
  ) = _$UpdateReviewRequestCopyWithImpl<$Res, UpdateReviewRequest>;
  @useResult
  $Res call({int rating, String? comment});
}

/// @nodoc
class _$UpdateReviewRequestCopyWithImpl<$Res, $Val extends UpdateReviewRequest>
    implements $UpdateReviewRequestCopyWith<$Res> {
  _$UpdateReviewRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UpdateReviewRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? rating = null, Object? comment = freezed}) {
    return _then(
      _value.copyWith(
            rating: null == rating
                ? _value.rating
                : rating // ignore: cast_nullable_to_non_nullable
                      as int,
            comment: freezed == comment
                ? _value.comment
                : comment // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UpdateReviewRequestImplCopyWith<$Res>
    implements $UpdateReviewRequestCopyWith<$Res> {
  factory _$$UpdateReviewRequestImplCopyWith(
    _$UpdateReviewRequestImpl value,
    $Res Function(_$UpdateReviewRequestImpl) then,
  ) = __$$UpdateReviewRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int rating, String? comment});
}

/// @nodoc
class __$$UpdateReviewRequestImplCopyWithImpl<$Res>
    extends _$UpdateReviewRequestCopyWithImpl<$Res, _$UpdateReviewRequestImpl>
    implements _$$UpdateReviewRequestImplCopyWith<$Res> {
  __$$UpdateReviewRequestImplCopyWithImpl(
    _$UpdateReviewRequestImpl _value,
    $Res Function(_$UpdateReviewRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UpdateReviewRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? rating = null, Object? comment = freezed}) {
    return _then(
      _$UpdateReviewRequestImpl(
        rating: null == rating
            ? _value.rating
            : rating // ignore: cast_nullable_to_non_nullable
                  as int,
        comment: freezed == comment
            ? _value.comment
            : comment // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UpdateReviewRequestImpl implements _UpdateReviewRequest {
  const _$UpdateReviewRequestImpl({required this.rating, this.comment});

  factory _$UpdateReviewRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$UpdateReviewRequestImplFromJson(json);

  @override
  final int rating;
  @override
  final String? comment;

  @override
  String toString() {
    return 'UpdateReviewRequest(rating: $rating, comment: $comment)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateReviewRequestImpl &&
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.comment, comment) || other.comment == comment));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, rating, comment);

  /// Create a copy of UpdateReviewRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateReviewRequestImplCopyWith<_$UpdateReviewRequestImpl> get copyWith =>
      __$$UpdateReviewRequestImplCopyWithImpl<_$UpdateReviewRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$UpdateReviewRequestImplToJson(this);
  }
}

abstract class _UpdateReviewRequest implements UpdateReviewRequest {
  const factory _UpdateReviewRequest({
    required final int rating,
    final String? comment,
  }) = _$UpdateReviewRequestImpl;

  factory _UpdateReviewRequest.fromJson(Map<String, dynamic> json) =
      _$UpdateReviewRequestImpl.fromJson;

  @override
  int get rating;
  @override
  String? get comment;

  /// Create a copy of UpdateReviewRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateReviewRequestImplCopyWith<_$UpdateReviewRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
