import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_report_model.freezed.dart';
part 'product_report_model.g.dart';

@freezed
class ProductReportModel with _$ProductReportModel {
  const factory ProductReportModel({
    required DateTime from,
    required DateTime to,
    required int totalProducts,
    required int outOfStockCount,
    required List<BestSellerItem> bestSellers,
    required List<StockLevelItem> stockLevels,
    required List<LowStockAlertItem> lowStockAlerts,
  }) = _ProductReportModel;

  factory ProductReportModel.fromJson(Map<String, dynamic> json) =>
      _$ProductReportModelFromJson(json);
}

@freezed
class BestSellerItem with _$BestSellerItem {
  const factory BestSellerItem({
    required String productName,
    required String categoryName,
    required int quantitySold,
    required double totalRevenue,
  }) = _BestSellerItem;

  factory BestSellerItem.fromJson(Map<String, dynamic> json) =>
      _$BestSellerItemFromJson(json);
}

@freezed
class StockLevelItem with _$StockLevelItem {
  const factory StockLevelItem({
    required String productName,
    required String categoryName,
    required int stockQuantity,
    required double price,
  }) = _StockLevelItem;

  factory StockLevelItem.fromJson(Map<String, dynamic> json) =>
      _$StockLevelItemFromJson(json);
}

@freezed
class LowStockAlertItem with _$LowStockAlertItem {
  const factory LowStockAlertItem({
    required String productName,
    required String categoryName,
    required int stockQuantity,
  }) = _LowStockAlertItem;

  factory LowStockAlertItem.fromJson(Map<String, dynamic> json) =>
      _$LowStockAlertItemFromJson(json);
}
