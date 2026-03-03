// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OrderModelImpl _$$OrderModelImplFromJson(Map<String, dynamic> json) =>
    _$OrderModelImpl(
      id: (json['id'] as num).toInt(),
      userId: (json['userId'] as num).toInt(),
      userFullName: json['userFullName'] as String,
      totalAmount: (json['totalAmount'] as num).toDouble(),
      status: (json['status'] as num).toInt(),
      stripePaymentIntentId: json['stripePaymentIntentId'] as String?,
      stripeClientSecret: json['stripeClientSecret'] as String?,
      items: (json['items'] as List<dynamic>)
          .map((e) => OrderItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$OrderModelImplToJson(_$OrderModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'userFullName': instance.userFullName,
      'totalAmount': instance.totalAmount,
      'status': instance.status,
      'stripePaymentIntentId': instance.stripePaymentIntentId,
      'stripeClientSecret': instance.stripeClientSecret,
      'items': instance.items,
      'createdAt': instance.createdAt.toIso8601String(),
    };
