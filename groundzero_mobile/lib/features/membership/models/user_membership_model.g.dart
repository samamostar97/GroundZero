// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_membership_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserMembershipModelImpl _$$UserMembershipModelImplFromJson(
  Map<String, dynamic> json,
) => _$UserMembershipModelImpl(
  id: (json['id'] as num).toInt(),
  userId: (json['userId'] as num).toInt(),
  userFullName: json['userFullName'] as String,
  userEmail: json['userEmail'] as String,
  planName: json['planName'] as String,
  planPrice: (json['planPrice'] as num).toDouble(),
  durationDays: (json['durationDays'] as num).toInt(),
  startDate: DateTime.parse(json['startDate'] as String),
  endDate: DateTime.parse(json['endDate'] as String),
  status: json['status'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$$UserMembershipModelImplToJson(
  _$UserMembershipModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'userId': instance.userId,
  'userFullName': instance.userFullName,
  'userEmail': instance.userEmail,
  'planName': instance.planName,
  'planPrice': instance.planPrice,
  'durationDays': instance.durationDays,
  'startDate': instance.startDate.toIso8601String(),
  'endDate': instance.endDate.toIso8601String(),
  'status': instance.status,
  'createdAt': instance.createdAt.toIso8601String(),
};
