// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_review_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UpdateReviewRequestImpl _$$UpdateReviewRequestImplFromJson(
  Map<String, dynamic> json,
) => _$UpdateReviewRequestImpl(
  rating: (json['rating'] as num).toInt(),
  comment: json['comment'] as String?,
);

Map<String, dynamic> _$$UpdateReviewRequestImplToJson(
  _$UpdateReviewRequestImpl instance,
) => <String, dynamic>{'rating': instance.rating, 'comment': instance.comment};
