import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_report_model.freezed.dart';
part 'user_report_model.g.dart';

@freezed
class UserReportModel with _$UserReportModel {
  const factory UserReportModel({
    required DateTime from,
    required DateTime to,
    required int totalUsers,
    required int newUsersInPeriod,
    required int activeUsersInPeriod,
    required double retentionRate,
    required List<MonthlyRegistrationItem> monthlyRegistrations,
    required List<UserActivityItem> mostActiveUsers,
  }) = _UserReportModel;

  factory UserReportModel.fromJson(Map<String, dynamic> json) =>
      _$UserReportModelFromJson(json);
}

@freezed
class MonthlyRegistrationItem with _$MonthlyRegistrationItem {
  const factory MonthlyRegistrationItem({
    required String month,
    required int year,
    required int count,
  }) = _MonthlyRegistrationItem;

  factory MonthlyRegistrationItem.fromJson(Map<String, dynamic> json) =>
      _$MonthlyRegistrationItemFromJson(json);
}

@freezed
class UserActivityItem with _$UserActivityItem {
  const factory UserActivityItem({
    required String fullName,
    required String email,
    required int gymVisits,
    required int totalMinutes,
  }) = _UserActivityItem;

  factory UserActivityItem.fromJson(Map<String, dynamic> json) =>
      _$UserActivityItemFromJson(json);
}
