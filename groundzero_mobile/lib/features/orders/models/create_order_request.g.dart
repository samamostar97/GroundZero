// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_order_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CreateOrderRequestImpl _$$CreateOrderRequestImplFromJson(
  Map<String, dynamic> json,
) => _$CreateOrderRequestImpl(
  items: (json['items'] as List<dynamic>)
      .map((e) => OrderItemRequest.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$$CreateOrderRequestImplToJson(
  _$CreateOrderRequestImpl instance,
) => <String, dynamic>{'items': instance.items};
