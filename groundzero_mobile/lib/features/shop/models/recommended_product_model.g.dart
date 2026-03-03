// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recommended_product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RecommendedProductModelImpl _$$RecommendedProductModelImplFromJson(
  Map<String, dynamic> json,
) => _$RecommendedProductModelImpl(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  description: json['description'] as String?,
  price: (json['price'] as num).toDouble(),
  imageUrl: json['imageUrl'] as String?,
  stockQuantity: (json['stockQuantity'] as num).toInt(),
  categoryId: (json['categoryId'] as num).toInt(),
  categoryName: json['categoryName'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
  coPurchaseCount: (json['coPurchaseCount'] as num).toInt(),
);

Map<String, dynamic> _$$RecommendedProductModelImplToJson(
  _$RecommendedProductModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'description': instance.description,
  'price': instance.price,
  'imageUrl': instance.imageUrl,
  'stockQuantity': instance.stockQuantity,
  'categoryId': instance.categoryId,
  'categoryName': instance.categoryName,
  'createdAt': instance.createdAt.toIso8601String(),
  'coPurchaseCount': instance.coPurchaseCount,
};
