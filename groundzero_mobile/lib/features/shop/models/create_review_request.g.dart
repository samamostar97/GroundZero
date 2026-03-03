// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_review_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CreateReviewRequestImpl _$$CreateReviewRequestImplFromJson(
  Map<String, dynamic> json,
) => _$CreateReviewRequestImpl(
  rating: (json['rating'] as num).toInt(),
  comment: json['comment'] as String?,
  reviewType: (json['reviewType'] as num).toInt(),
  productId: (json['productId'] as num?)?.toInt(),
  appointmentId: (json['appointmentId'] as num?)?.toInt(),
);

Map<String, dynamic> _$$CreateReviewRequestImplToJson(
  _$CreateReviewRequestImpl instance,
) => <String, dynamic>{
  'rating': instance.rating,
  'comment': instance.comment,
  'reviewType': instance.reviewType,
  'productId': instance.productId,
  'appointmentId': instance.appointmentId,
};
