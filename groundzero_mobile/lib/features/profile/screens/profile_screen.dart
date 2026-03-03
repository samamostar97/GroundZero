import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/routing/app_router.dart';
import '../../../shared/widgets/error_display.dart';
import '../../../shared/widgets/gamification_card.dart';
import '../../../shared/widgets/skeletons.dart';
import '../../../shared/widgets/user_avatar.dart';
import '../../auth/providers/auth_provider.dart';
import '../../auth/providers/user_provider.dart';
import '../providers/gamification_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(userNotifierProvider);
    final gamificationAsync = ref.watch(gamificationProvider);

    return Scaffold(
      body: SafeArea(
        child: userAsync.when(
          loading: () => const ProfileSkeleton(),
          error: (error, _) => ErrorDisplay(
            message: 'Greška pri učitavanju profila.',
            onRetry: () =>
                ref.read(userNotifierProvider.notifier).refresh(),
          ),
          data: (user) {
            if (user == null) {
              return const ProfileSkeleton();
            }

            return ListView(
              padding: const EdgeInsets.all(20),
              children: [
                const SizedBox(height: 10),

                // Avatar + Name
                Center(
                  child: UserAvatar(
                    imageUrl: user.profileImageUrl,
                    firstName: user.firstName,
                    lastName: user.lastName,
                    radius: 48,
                  ),
                ),
                const SizedBox(height: 16),
                Center(
                  child: Text(
                    '${user.firstName} ${user.lastName}',
                    style: AppTextStyles.heading2,
                  ),
                ),
                const SizedBox(height: 4),
                Center(
                  child: Text(
                    user.email,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Gamification card
                gamificationAsync.when(
                  loading: () => const GamificationCardSkeleton(),
                  error: (_, _) => const SizedBox.shrink(),
                  data: (gamification) => GamificationCard(
                    level: gamification.level,
                    levelName: gamification.levelName,
                    xp: gamification.xp,
                    nextLevelXP: gamification.nextLevelXP,
                    rank: gamification.rank,
                    totalGymMinutes: gamification.totalGymMinutes,
                  ),
                ),
                const SizedBox(height: 24),

                // Menu items
                _MenuTile(
                  icon: Icons.edit_rounded,
                  label: 'Uredi profil',
                  onTap: () => context.push(AppRoutes.editProfile),
                ),
                const SizedBox(height: 10),
                _MenuTile(
                  icon: Icons.leaderboard_rounded,
                  label: 'Rang lista',
                  onTap: () => context.push(AppRoutes.leaderboard),
                ),
                const SizedBox(height: 10),
                _MenuTile(
                  icon: Icons.calendar_today_rounded,
                  label: 'Moji termini',
                  onTap: () => context.push('/appointments'),
                ),
                const SizedBox(height: 10),
                _MenuTile(
                  icon: Icons.people_outline_rounded,
                  label: 'Osoblje',
                  onTap: () => context.push('/staff'),
                ),
                const SizedBox(height: 10),
                _MenuTile(
                  icon: Icons.receipt_long_rounded,
                  label: 'Moje narudžbe',
                  onTap: () => context.push('/orders'),
                ),
                const SizedBox(height: 24),

                // Logout
                _MenuTile(
                  icon: Icons.logout_rounded,
                  label: 'Odjava',
                  color: AppColors.error,
                  onTap: () {
                    ref.read(authNotifierProvider.notifier).logout();
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _MenuTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color? color;

  const _MenuTile({
    required this.icon,
    required this.label,
    required this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final tileColor = color ?? AppColors.textPrimary;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            Icon(icon, color: tileColor, size: 22),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                label,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: tileColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Icon(
              Icons.chevron_right_rounded,
              color: AppColors.textHint,
              size: 22,
            ),
          ],
        ),
      ),
    );
  }
}
