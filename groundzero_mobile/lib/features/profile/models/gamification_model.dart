import 'package:freezed_annotation/freezed_annotation.dart';

part 'gamification_model.freezed.dart';
part 'gamification_model.g.dart';

@freezed
class GamificationModel with _$GamificationModel {
  const factory GamificationModel({
    required int xp,
    required int level,
    required String levelName,
    required int totalGymMinutes,
    required int rank,
    int? nextLevelXP,
  }) = _GamificationModel;

  factory GamificationModel.fromJson(Map<String, dynamic> json) =>
      _$GamificationModelFromJson(json);
}
