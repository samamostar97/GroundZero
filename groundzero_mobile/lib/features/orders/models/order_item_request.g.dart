// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_item_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OrderItemRequestImpl _$$OrderItemRequestImplFromJson(
  Map<String, dynamic> json,
) => _$OrderItemRequestImpl(
  productId: (json['productId'] as num).toInt(),
  quantity: (json['quantity'] as num).toInt(),
);

Map<String, dynamic> _$$OrderItemRequestImplToJson(
  _$OrderItemRequestImpl instance,
) => <String, dynamic>{
  'productId': instance.productId,
  'quantity': instance.quantity,
};
