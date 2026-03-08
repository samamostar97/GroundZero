// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gamification_report_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GamificationReportModelImpl _$$GamificationReportModelImplFromJson(
  Map<String, dynamic> json,
) => _$GamificationReportModelImpl(
  from: DateTime.parse(json['from'] as String),
  to: DateTime.parse(json['to'] as String),
  totalGymVisits: (json['totalGymVisits'] as num).toInt(),
  avgVisitDurationMinutes: (json['avgVisitDurationMinutes'] as num).toDouble(),
  levelDistribution: (json['levelDistribution'] as List<dynamic>)
      .map((e) => LevelDistributionItem.fromJson(e as Map<String, dynamic>))
      .toList(),
  topUsers: (json['topUsers'] as List<dynamic>)
      .map((e) => LeaderboardSummaryItem.fromJson(e as Map<String, dynamic>))
      .toList(),
  dailyVisits: (json['dailyVisits'] as List<dynamic>)
      .map((e) => DailyVisitItem.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$$GamificationReportModelImplToJson(
  _$GamificationReportModelImpl instance,
) => <String, dynamic>{
  'from': instance.from.toIso8601String(),
  'to': instance.to.toIso8601String(),
  'totalGymVisits': instance.totalGymVisits,
  'avgVisitDurationMinutes': instance.avgVisitDurationMinutes,
  'levelDistribution': instance.levelDistribution,
  'topUsers': instance.topUsers,
  'dailyVisits': instance.dailyVisits,
};

_$LevelDistributionItemImpl _$$LevelDistributionItemImplFromJson(
  Map<String, dynamic> json,
) => _$LevelDistributionItemImpl(
  levelName: json['levelName'] as String,
  userCount: (json['userCount'] as num).toInt(),
);

Map<String, dynamic> _$$LevelDistributionItemImplToJson(
  _$LevelDistributionItemImpl instance,
) => <String, dynamic>{
  'levelName': instance.levelName,
  'userCount': instance.userCount,
};

_$LeaderboardSummaryItemImpl _$$LeaderboardSummaryItemImplFromJson(
  Map<String, dynamic> json,
) => _$LeaderboardSummaryItemImpl(
  fullName: json['fullName'] as String,
  email: json['email'] as String,
  level: (json['level'] as num).toInt(),
  xp: (json['xp'] as num).toInt(),
  totalGymMinutes: (json['totalGymMinutes'] as num).toInt(),
);

Map<String, dynamic> _$$LeaderboardSummaryItemImplToJson(
  _$LeaderboardSummaryItemImpl instance,
) => <String, dynamic>{
  'fullName': instance.fullName,
  'email': instance.email,
  'level': instance.level,
  'xp': instance.xp,
  'totalGymMinutes': instance.totalGymMinutes,
};

_$DailyVisitItemImpl _$$DailyVisitItemImplFromJson(Map<String, dynamic> json) =>
    _$DailyVisitItemImpl(
      date: DateTime.parse(json['date'] as String),
      visitCount: (json['visitCount'] as num).toInt(),
      avgDurationMinutes: (json['avgDurationMinutes'] as num).toDouble(),
    );

Map<String, dynamic> _$$DailyVisitItemImplToJson(
  _$DailyVisitItemImpl instance,
) => <String, dynamic>{
  'date': instance.date.toIso8601String(),
  'visitCount': instance.visitCount,
  'avgDurationMinutes': instance.avgDurationMinutes,
};
