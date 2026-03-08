// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DashboardModelImpl _$$DashboardModelImplFromJson(Map<String, dynamic> json) =>
    _$DashboardModelImpl(
      currentlyInGym: (json['currentlyInGym'] as num).toInt(),
      pendingOrderCount: (json['pendingOrderCount'] as num).toInt(),
      todayAppointments: (json['todayAppointments'] as num).toInt(),
      newUsersThisMonth: (json['newUsersThisMonth'] as num).toInt(),
      activeGymVisits: (json['activeGymVisits'] as List<dynamic>)
          .map((e) => ActiveGymVisitItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      pendingOrders: (json['pendingOrders'] as List<dynamic>)
          .map((e) => PendingOrderItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$DashboardModelImplToJson(
  _$DashboardModelImpl instance,
) => <String, dynamic>{
  'currentlyInGym': instance.currentlyInGym,
  'pendingOrderCount': instance.pendingOrderCount,
  'todayAppointments': instance.todayAppointments,
  'newUsersThisMonth': instance.newUsersThisMonth,
  'activeGymVisits': instance.activeGymVisits,
  'pendingOrders': instance.pendingOrders,
};

_$ActiveGymVisitItemImpl _$$ActiveGymVisitItemImplFromJson(
  Map<String, dynamic> json,
) => _$ActiveGymVisitItemImpl(
  id: (json['id'] as num).toInt(),
  userId: (json['userId'] as num).toInt(),
  userFullName: json['userFullName'] as String,
  checkInAt: DateTime.parse(json['checkInAt'] as String),
);

Map<String, dynamic> _$$ActiveGymVisitItemImplToJson(
  _$ActiveGymVisitItemImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'userId': instance.userId,
  'userFullName': instance.userFullName,
  'checkInAt': instance.checkInAt.toIso8601String(),
};

_$PendingOrderItemImpl _$$PendingOrderItemImplFromJson(
  Map<String, dynamic> json,
) => _$PendingOrderItemImpl(
  id: (json['id'] as num).toInt(),
  userId: (json['userId'] as num).toInt(),
  userFullName: json['userFullName'] as String,
  totalAmount: (json['totalAmount'] as num).toDouble(),
  itemCount: (json['itemCount'] as num).toInt(),
  createdAt: DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$$PendingOrderItemImplToJson(
  _$PendingOrderItemImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'userId': instance.userId,
  'userFullName': instance.userFullName,
  'totalAmount': instance.totalAmount,
  'itemCount': instance.itemCount,
  'createdAt': instance.createdAt.toIso8601String(),
};
