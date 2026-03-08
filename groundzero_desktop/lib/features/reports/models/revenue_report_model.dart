import 'package:freezed_annotation/freezed_annotation.dart';

part 'revenue_report_model.freezed.dart';
part 'revenue_report_model.g.dart';

@freezed
class RevenueReportModel with _$RevenueReportModel {
  const factory RevenueReportModel({
    required DateTime from,
    required DateTime to,
    required double totalOrderRevenue,
    required int totalOrders,
    required int totalAppointments,
    required List<MonthlyRevenueItem> monthlyRevenue,
    required List<CategoryRevenueItem> categoryRevenue,
  }) = _RevenueReportModel;

  factory RevenueReportModel.fromJson(Map<String, dynamic> json) =>
      _$RevenueReportModelFromJson(json);
}

@freezed
class MonthlyRevenueItem with _$MonthlyRevenueItem {
  const factory MonthlyRevenueItem({
    required String month,
    required int year,
    required double revenue,
    required int orderCount,
  }) = _MonthlyRevenueItem;

  factory MonthlyRevenueItem.fromJson(Map<String, dynamic> json) =>
      _$MonthlyRevenueItemFromJson(json);
}

@freezed
class CategoryRevenueItem with _$CategoryRevenueItem {
  const factory CategoryRevenueItem({
    required String categoryName,
    required double revenue,
    required int itemsSold,
  }) = _CategoryRevenueItem;

  factory CategoryRevenueItem.fromJson(Map<String, dynamic> json) =>
      _$CategoryRevenueItemFromJson(json);
}
