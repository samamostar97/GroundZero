// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gamification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GamificationModelImpl _$$GamificationModelImplFromJson(
  Map<String, dynamic> json,
) => _$GamificationModelImpl(
  xp: (json['xp'] as num).toInt(),
  level: (json['level'] as num).toInt(),
  levelName: json['levelName'] as String,
  totalGymMinutes: (json['totalGymMinutes'] as num).toInt(),
  rank: (json['rank'] as num).toInt(),
  nextLevelXP: (json['nextLevelXP'] as num?)?.toInt(),
);

Map<String, dynamic> _$$GamificationModelImplToJson(
  _$GamificationModelImpl instance,
) => <String, dynamic>{
  'xp': instance.xp,
  'level': instance.level,
  'levelName': instance.levelName,
  'totalGymMinutes': instance.totalGymMinutes,
  'rank': instance.rank,
  'nextLevelXP': instance.nextLevelXP,
};
