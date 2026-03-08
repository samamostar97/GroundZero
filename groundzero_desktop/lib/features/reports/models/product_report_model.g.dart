// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_report_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProductReportModelImpl _$$ProductReportModelImplFromJson(
  Map<String, dynamic> json,
) => _$ProductReportModelImpl(
  from: DateTime.parse(json['from'] as String),
  to: DateTime.parse(json['to'] as String),
  totalProducts: (json['totalProducts'] as num).toInt(),
  outOfStockCount: (json['outOfStockCount'] as num).toInt(),
  bestSellers: (json['bestSellers'] as List<dynamic>)
      .map((e) => BestSellerItem.fromJson(e as Map<String, dynamic>))
      .toList(),
  stockLevels: (json['stockLevels'] as List<dynamic>)
      .map((e) => StockLevelItem.fromJson(e as Map<String, dynamic>))
      .toList(),
  lowStockAlerts: (json['lowStockAlerts'] as List<dynamic>)
      .map((e) => LowStockAlertItem.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$$ProductReportModelImplToJson(
  _$ProductReportModelImpl instance,
) => <String, dynamic>{
  'from': instance.from.toIso8601String(),
  'to': instance.to.toIso8601String(),
  'totalProducts': instance.totalProducts,
  'outOfStockCount': instance.outOfStockCount,
  'bestSellers': instance.bestSellers,
  'stockLevels': instance.stockLevels,
  'lowStockAlerts': instance.lowStockAlerts,
};

_$BestSellerItemImpl _$$BestSellerItemImplFromJson(Map<String, dynamic> json) =>
    _$BestSellerItemImpl(
      productName: json['productName'] as String,
      categoryName: json['categoryName'] as String,
      quantitySold: (json['quantitySold'] as num).toInt(),
      totalRevenue: (json['totalRevenue'] as num).toDouble(),
    );

Map<String, dynamic> _$$BestSellerItemImplToJson(
  _$BestSellerItemImpl instance,
) => <String, dynamic>{
  'productName': instance.productName,
  'categoryName': instance.categoryName,
  'quantitySold': instance.quantitySold,
  'totalRevenue': instance.totalRevenue,
};

_$StockLevelItemImpl _$$StockLevelItemImplFromJson(Map<String, dynamic> json) =>
    _$StockLevelItemImpl(
      productName: json['productName'] as String,
      categoryName: json['categoryName'] as String,
      stockQuantity: (json['stockQuantity'] as num).toInt(),
      price: (json['price'] as num).toDouble(),
    );

Map<String, dynamic> _$$StockLevelItemImplToJson(
  _$StockLevelItemImpl instance,
) => <String, dynamic>{
  'productName': instance.productName,
  'categoryName': instance.categoryName,
  'stockQuantity': instance.stockQuantity,
  'price': instance.price,
};

_$LowStockAlertItemImpl _$$LowStockAlertItemImplFromJson(
  Map<String, dynamic> json,
) => _$LowStockAlertItemImpl(
  productName: json['productName'] as String,
  categoryName: json['categoryName'] as String,
  stockQuantity: (json['stockQuantity'] as num).toInt(),
);

Map<String, dynamic> _$$LowStockAlertItemImplToJson(
  _$LowStockAlertItemImpl instance,
) => <String, dynamic>{
  'productName': instance.productName,
  'categoryName': instance.categoryName,
  'stockQuantity': instance.stockQuantity,
};
