// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'revenue_report_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RevenueReportModelImpl _$$RevenueReportModelImplFromJson(
  Map<String, dynamic> json,
) => _$RevenueReportModelImpl(
  from: DateTime.parse(json['from'] as String),
  to: DateTime.parse(json['to'] as String),
  totalOrderRevenue: (json['totalOrderRevenue'] as num).toDouble(),
  totalOrders: (json['totalOrders'] as num).toInt(),
  totalAppointments: (json['totalAppointments'] as num).toInt(),
  monthlyRevenue: (json['monthlyRevenue'] as List<dynamic>)
      .map((e) => MonthlyRevenueItem.fromJson(e as Map<String, dynamic>))
      .toList(),
  categoryRevenue: (json['categoryRevenue'] as List<dynamic>)
      .map((e) => CategoryRevenueItem.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$$RevenueReportModelImplToJson(
  _$RevenueReportModelImpl instance,
) => <String, dynamic>{
  'from': instance.from.toIso8601String(),
  'to': instance.to.toIso8601String(),
  'totalOrderRevenue': instance.totalOrderRevenue,
  'totalOrders': instance.totalOrders,
  'totalAppointments': instance.totalAppointments,
  'monthlyRevenue': instance.monthlyRevenue,
  'categoryRevenue': instance.categoryRevenue,
};

_$MonthlyRevenueItemImpl _$$MonthlyRevenueItemImplFromJson(
  Map<String, dynamic> json,
) => _$MonthlyRevenueItemImpl(
  month: json['month'] as String,
  year: (json['year'] as num).toInt(),
  revenue: (json['revenue'] as num).toDouble(),
  orderCount: (json['orderCount'] as num).toInt(),
);

Map<String, dynamic> _$$MonthlyRevenueItemImplToJson(
  _$MonthlyRevenueItemImpl instance,
) => <String, dynamic>{
  'month': instance.month,
  'year': instance.year,
  'revenue': instance.revenue,
  'orderCount': instance.orderCount,
};

_$CategoryRevenueItemImpl _$$CategoryRevenueItemImplFromJson(
  Map<String, dynamic> json,
) => _$CategoryRevenueItemImpl(
  categoryName: json['categoryName'] as String,
  revenue: (json['revenue'] as num).toDouble(),
  itemsSold: (json['itemsSold'] as num).toInt(),
);

Map<String, dynamic> _$$CategoryRevenueItemImplToJson(
  _$CategoryRevenueItemImpl instance,
) => <String, dynamic>{
  'categoryName': instance.categoryName,
  'revenue': instance.revenue,
  'itemsSold': instance.itemsSold,
};
