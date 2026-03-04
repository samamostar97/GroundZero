import 'package:freezed_annotation/freezed_annotation.dart';

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
    required List<OrderItemModel> items,
    required DateTime createdAt,
  }) = _OrderModel;

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);
}

@freezed
class OrderItemModel with _$OrderItemModel {
  const factory OrderItemModel({
    required int id,
    required int productId,
    required String productName,
    String? productImageUrl,
    required int quantity,
    required double unitPrice,
    required double subtotal,
  }) = _OrderItemModel;

  factory OrderItemModel.fromJson(Map<String, dynamic> json) =>
      _$OrderItemModelFromJson(json);
}
