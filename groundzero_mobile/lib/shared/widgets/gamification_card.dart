import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';

class GamificationCard extends StatelessWidget {
  final int level;
  final String levelName;
  final int xp;
  final int? nextLevelXP;
  final int rank;
  final int totalGymMinutes;

  const GamificationCard({
    super.key,
    required this.level,
    required this.levelName,
    required this.xp,
    this.nextLevelXP,
    required this.rank,
    required this.totalGymMinutes,
  });

  @override
  Widget build(BuildContext context) {
    final double progress = nextLevelXP != null && nextLevelXP! > 0
        ? (xp / nextLevelXP!).clamp(0.0, 1.0)
        : 1.0;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Level + Rank row
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: AppColors.accent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Lvl $level',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.onAccent,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                levelName,
                style: AppTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              Icon(
                Icons.emoji_events_rounded,
                color: AppColors.warning,
                size: 18,
              ),
              const SizedBox(width: 4),
              Text(
                '#$rank',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.warning,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          // XP Progress
          Row(
            children: [
              Text(
                '$xp XP',
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.accent,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              if (nextLevelXP != null)
                Text(
                  '$nextLevelXP XP',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textHint,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 6,
              backgroundColor: AppColors.inputFill,
              valueColor:
                  const AlwaysStoppedAnimation<Color>(AppColors.accent),
            ),
          ),

          const SizedBox(height: 14),

          // Gym time
          Row(
            children: [
              const Icon(
                Icons.timer_outlined,
                color: AppColors.textSecondary,
                size: 16,
              ),
              const SizedBox(width: 6),
              Text(
                _formatMinutes(totalGymMinutes),
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatMinutes(int minutes) {
    final hours = minutes ~/ 60;
    final mins = minutes % 60;
    if (hours > 0) {
      return '${hours}h ${mins}min u teretani';
    }
    return '${mins}min u teretani';
  }
}
