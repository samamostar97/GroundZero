// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leaderboard_entry_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LeaderboardEntryModelImpl _$$LeaderboardEntryModelImplFromJson(
  Map<String, dynamic> json,
) => _$LeaderboardEntryModelImpl(
  rank: (json['rank'] as num).toInt(),
  userId: (json['userId'] as num).toInt(),
  userFullName: json['userFullName'] as String,
  profileImageUrl: json['profileImageUrl'] as String?,
  level: (json['level'] as num).toInt(),
  levelName: json['levelName'] as String,
  xp: (json['xp'] as num).toInt(),
  totalGymMinutes: (json['totalGymMinutes'] as num).toInt(),
);

Map<String, dynamic> _$$LeaderboardEntryModelImplToJson(
  _$LeaderboardEntryModelImpl instance,
) => <String, dynamic>{
  'rank': instance.rank,
  'userId': instance.userId,
  'userFullName': instance.userFullName,
  'profileImageUrl': instance.profileImageUrl,
  'level': instance.level,
  'levelName': instance.levelName,
  'xp': instance.xp,
  'totalGymMinutes': instance.totalGymMinutes,
};
