// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'membership_plan_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MembershipPlanModelImpl _$$MembershipPlanModelImplFromJson(
  Map<String, dynamic> json,
) => _$MembershipPlanModelImpl(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  description: json['description'] as String?,
  price: (json['price'] as num).toDouble(),
  durationDays: (json['durationDays'] as num).toInt(),
  isActive: json['isActive'] as bool,
  createdAt: DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$$MembershipPlanModelImplToJson(
  _$MembershipPlanModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'description': instance.description,
  'price': instance.price,
  'durationDays': instance.durationDays,
  'isActive': instance.isActive,
  'createdAt': instance.createdAt.toIso8601String(),
};
