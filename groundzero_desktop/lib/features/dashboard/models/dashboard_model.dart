import 'package:freezed_annotation/freezed_annotation.dart';

part 'dashboard_model.freezed.dart';
part 'dashboard_model.g.dart';

@freezed
class DashboardModel with _$DashboardModel {
  const factory DashboardModel({
    required int currentlyInGym,
    required int pendingOrderCount,
    required int pendingAppointmentCount,
    required int newUsersThisMonth,
    required List<ActiveGymVisitItem> activeGymVisits,
    required List<PendingOrderItem> pendingOrders,
  }) = _DashboardModel;

  factory DashboardModel.fromJson(Map<String, dynamic> json) =>
      _$DashboardModelFromJson(json);
}

@freezed
class ActiveGymVisitItem with _$ActiveGymVisitItem {
  const factory ActiveGymVisitItem({
    required int id,
    required int userId,
    required String userFullName,
    required DateTime checkInAt,
  }) = _ActiveGymVisitItem;

  factory ActiveGymVisitItem.fromJson(Map<String, dynamic> json) =>
      _$ActiveGymVisitItemFromJson(json);
}

@freezed
class PendingOrderItem with _$PendingOrderItem {
  const factory PendingOrderItem({
    required int id,
    required int userId,
    required String userFullName,
    required double totalAmount,
    required int itemCount,
    required DateTime createdAt,
  }) = _PendingOrderItem;

  factory PendingOrderItem.fromJson(Map<String, dynamic> json) =>
      _$PendingOrderItemFromJson(json);
}
