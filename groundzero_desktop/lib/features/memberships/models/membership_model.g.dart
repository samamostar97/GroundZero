// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'membership_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MembershipModelImpl _$$MembershipModelImplFromJson(
  Map<String, dynamic> json,
) => _$MembershipModelImpl(
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

Map<String, dynamic> _$$MembershipModelImplToJson(
  _$MembershipModelImpl instance,
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
