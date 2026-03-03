import 'package:freezed_annotation/freezed_annotation.dart';

part 'recommended_product_model.freezed.dart';
part 'recommended_product_model.g.dart';

@freezed
class RecommendedProductModel with _$RecommendedProductModel {
  const factory RecommendedProductModel({
    required int id,
    required String name,
    String? description,
    required double price,
    String? imageUrl,
    required int stockQuantity,
    required int categoryId,
    required String categoryName,
    required DateTime createdAt,
    required int coPurchaseCount,
  }) = _RecommendedProductModel;

  factory RecommendedProductModel.fromJson(Map<String, dynamic> json) =>
      _$RecommendedProductModelFromJson(json);
}
