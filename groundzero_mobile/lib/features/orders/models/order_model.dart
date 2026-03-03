import 'package:freezed_annotation/freezed_annotation.dart';

import 'order_item_model.dart';

part 'order_model.freezed.dart';
part 'order_model.g.dart';

@freezed
class OrderModel with _$OrderModel {
  const factory OrderModel({
    required int id,
    required int userId,
    required String userFullName,
    required double totalAmount,
    required int status,
    String? stripePaymentIntentId,
    String? stripeClientSecret,
    required List<OrderItemModel> items,
    required DateTime createdAt,
  }) = _OrderModel;

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);
}
