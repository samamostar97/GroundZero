import 'package:freezed_annotation/freezed_annotation.dart';

part 'leaderboard_entry_model.freezed.dart';
part 'leaderboard_entry_model.g.dart';

@freezed
class LeaderboardEntryModel with _$LeaderboardEntryModel {
  const factory LeaderboardEntryModel({
    required int rank,
    required int userId,
    required String userFullName,
    String? profileImageUrl,
    required int level,
    required String levelName,
    required int xp,
    required int totalGymMinutes,
  }) = _LeaderboardEntryModel;

  factory LeaderboardEntryModel.fromJson(Map<String, dynamic> json) =>
      _$LeaderboardEntryModelFromJson(json);
}
