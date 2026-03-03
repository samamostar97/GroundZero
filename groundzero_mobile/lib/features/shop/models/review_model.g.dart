// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReviewModelImpl _$$ReviewModelImplFromJson(Map<String, dynamic> json) =>
    _$ReviewModelImpl(
      id: (json['id'] as num).toInt(),
      userId: (json['userId'] as num).toInt(),
      userFullName: json['userFullName'] as String,
      rating: (json['rating'] as num).toInt(),
      comment: json['comment'] as String?,
      reviewType: json['reviewType'] as String,
      productId: (json['productId'] as num?)?.toInt(),
      productName: json['productName'] as String?,
      appointmentId: (json['appointmentId'] as num?)?.toInt(),
      staffFullName: json['staffFullName'] as String?,
      staffType: json['staffType'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$ReviewModelImplToJson(_$ReviewModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'userFullName': instance.userFullName,
      'rating': instance.rating,
      'comment': instance.comment,
      'reviewType': instance.reviewType,
      'productId': instance.productId,
      'productName': instance.productName,
      'appointmentId': instance.appointmentId,
      'staffFullName': instance.staffFullName,
      'staffType': instance.staffType,
      'createdAt': instance.createdAt.toIso8601String(),
    };
