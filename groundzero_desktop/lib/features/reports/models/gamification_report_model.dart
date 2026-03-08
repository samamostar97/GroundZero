import 'package:freezed_annotation/freezed_annotation.dart';

part 'gamification_report_model.freezed.dart';
part 'gamification_report_model.g.dart';


@freezed
class GamificationReportModel with _$GamificationReportModel {
  const factory GamificationReportModel({
    required DateTime from,
    required DateTime to,
    required int totalGymVisits,
    required double avgVisitDurationMinutes,
    required List<LevelDistributionItem> levelDistribution,
    required List<LeaderboardSummaryItem> topUsers,
    required List<DailyVisitItem> dailyVisits,
  }) = _GamificationReportModel;

  factory GamificationReportModel.fromJson(Map<String, dynamic> json) =>
      _$GamificationReportModelFromJson(json);
}

@freezed
class LevelDistributionItem with _$LevelDistributionItem {
  const factory LevelDistributionItem({
    required String levelName,
    required int userCount,
  }) = _LevelDistributionItem;

  factory LevelDistributionItem.fromJson(Map<String, dynamic> json) =>
      _$LevelDistributionItemFromJson(json);
}

@freezed
class LeaderboardSummaryItem with _$LeaderboardSummaryItem {
  const factory LeaderboardSummaryItem({
    required String fullName,
    required String email,
    required int level,
    required int xp,
    required int totalGymMinutes,
  }) = _LeaderboardSummaryItem;

  factory LeaderboardSummaryItem.fromJson(Map<String, dynamic> json) =>
      _$LeaderboardSummaryItemFromJson(json);
}

@freezed
class DailyVisitItem with _$DailyVisitItem {
  const factory DailyVisitItem({
    required DateTime date,
    required int visitCount,
    required double avgDurationMinutes,
  }) = _DailyVisitItem;

  factory DailyVisitItem.fromJson(Map<String, dynamic> json) =>
      _$DailyVisitItemFromJson(json);
}
