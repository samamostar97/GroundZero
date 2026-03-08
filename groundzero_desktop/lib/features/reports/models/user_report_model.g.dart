// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_report_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserReportModelImpl _$$UserReportModelImplFromJson(
  Map<String, dynamic> json,
) => _$UserReportModelImpl(
  from: DateTime.parse(json['from'] as String),
  to: DateTime.parse(json['to'] as String),
  totalUsers: (json['totalUsers'] as num).toInt(),
  newUsersInPeriod: (json['newUsersInPeriod'] as num).toInt(),
  activeUsersInPeriod: (json['activeUsersInPeriod'] as num).toInt(),
  retentionRate: (json['retentionRate'] as num).toDouble(),
  monthlyRegistrations: (json['monthlyRegistrations'] as List<dynamic>)
      .map((e) => MonthlyRegistrationItem.fromJson(e as Map<String, dynamic>))
      .toList(),
  mostActiveUsers: (json['mostActiveUsers'] as List<dynamic>)
      .map((e) => UserActivityItem.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$$UserReportModelImplToJson(
  _$UserReportModelImpl instance,
) => <String, dynamic>{
  'from': instance.from.toIso8601String(),
  'to': instance.to.toIso8601String(),
  'totalUsers': instance.totalUsers,
  'newUsersInPeriod': instance.newUsersInPeriod,
  'activeUsersInPeriod': instance.activeUsersInPeriod,
  'retentionRate': instance.retentionRate,
  'monthlyRegistrations': instance.monthlyRegistrations,
  'mostActiveUsers': instance.mostActiveUsers,
};

_$MonthlyRegistrationItemImpl _$$MonthlyRegistrationItemImplFromJson(
  Map<String, dynamic> json,
) => _$MonthlyRegistrationItemImpl(
  month: json['month'] as String,
  year: (json['year'] as num).toInt(),
  count: (json['count'] as num).toInt(),
);

Map<String, dynamic> _$$MonthlyRegistrationItemImplToJson(
  _$MonthlyRegistrationItemImpl instance,
) => <String, dynamic>{
  'month': instance.month,
  'year': instance.year,
  'count': instance.count,
};

_$UserActivityItemImpl _$$UserActivityItemImplFromJson(
  Map<String, dynamic> json,
) => _$UserActivityItemImpl(
  fullName: json['fullName'] as String,
  email: json['email'] as String,
  gymVisits: (json['gymVisits'] as num).toInt(),
  totalMinutes: (json['totalMinutes'] as num).toInt(),
);

Map<String, dynamic> _$$UserActivityItemImplToJson(
  _$UserActivityItemImpl instance,
) => <String, dynamic>{
  'fullName': instance.fullName,
  'email': instance.email,
  'gymVisits': instance.gymVisits,
  'totalMinutes': instance.totalMinutes,
};
