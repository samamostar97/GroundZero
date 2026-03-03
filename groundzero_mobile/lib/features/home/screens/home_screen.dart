import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_shadows.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/routing/app_router.dart';
import '../../../shared/widgets/error_display.dart';
import '../../../shared/widgets/gamification_card.dart';
import '../../../shared/widgets/product_card.dart';
import '../../../shared/widgets/skeletons.dart';
import '../../../shared/widgets/staff_card.dart';
import '../../../shared/widgets/user_avatar.dart';
import '../../appointments/providers/staff_provider.dart';
import '../../auth/providers/user_provider.dart';
import '../../membership/providers/membership_provider.dart';
import '../../profile/providers/gamification_provider.dart';
import '../../shop/providers/recommendations_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(userNotifierProvider);
    final gamificationAsync = ref.watch(gamificationProvider);
    final membershipAsync = ref.watch(currentMembershipProvider);
    final recommendationsAsync = ref.watch(recommendationsProvider);
    final staffAsync = ref.watch(featuredStaffProvider);

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

            return RefreshIndicator(
              color: AppColors.accent,
              onRefresh: () async {
                ref.invalidate(gamificationProvider);
                ref.invalidate(currentMembershipProvider);
                ref.invalidate(recommendationsProvider);
                ref.invalidate(featuredStaffProvider);
                ref.read(userNotifierProvider.notifier).refresh();
              },
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  // Welcome header with avatar
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Dobrodošli,',
                              style: AppTextStyles.bodyLarge.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                            Text(
                              '${user.firstName} ${user.lastName}!',
                              style: AppTextStyles.heading1.copyWith(
                                color: AppColors.accent,
                              ),
                            ),
                          ],
                        ),
                      ),
                      UserAvatar(
                        imageUrl: user.profileImageUrl,
                        firstName: user.firstName,
                        lastName: user.lastName,
                        radius: 30,
                      ),
                    ],
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
                  const SizedBox(height: 12),

                  // Membership status card
                  membershipAsync.when(
                    loading: () => const SizedBox.shrink(),
                    error: (_, _) => const SizedBox.shrink(),
                    data: (membership) {
                      final isActive = membership != null &&
                          membership.status == 'Active';
                      return GestureDetector(
                        onTap: () => context.push(AppRoutes.membership),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.surface,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: AppShadows.card,
                            border: isActive
                                ? Border.all(
                                    color: AppColors.accent
                                        .withValues(alpha: 0.2),
                                  )
                                : null,
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.card_membership_rounded,
                                color: isActive
                                    ? AppColors.accent
                                    : AppColors.textHint,
                                size: 22,
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      isActive
                                          ? membership.planName
                                          : 'Nema aktivne članarine',
                                      style:
                                          AppTextStyles.bodyMedium.copyWith(
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    if (isActive) ...[
                                      const SizedBox(height: 2),
                                      Text(
                                        'Aktivna do ${_formatDate(membership.endDate)}',
                                        style: AppTextStyles.bodySmall
                                            .copyWith(
                                          color: AppColors.accent,
                                        ),
                                      ),
                                    ],
                                  ],
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
                    },
                  ),

                  const SizedBox(height: 28),

                  // Recommendations section
                  Text(
                    'Preporučeno za vas',
                    style: AppTextStyles.heading3,
                  ),
                  const SizedBox(height: 14),
                  recommendationsAsync.when(
                    loading: () => SizedBox(
                      height: 240,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: 3,
                        separatorBuilder: (_, _) => const SizedBox(width: 12),
                        itemBuilder: (_, _) => const SizedBox(
                          width: 160,
                          child: ProductCardSkeleton(),
                        ),
                      ),
                    ),
                    error: (_, _) => Text(
                      'Nije moguće učitati preporuke.',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textHint,
                      ),
                    ),
                    data: (recommendations) {
                      if (recommendations.isEmpty) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Text(
                            'Nema preporuka za sada.',
                            style: AppTextStyles.bodySmall.copyWith(
                              color: AppColors.textHint,
                            ),
                          ),
                        );
                      }

                      return SizedBox(
                        height: 240,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: recommendations.length,
                          separatorBuilder: (_, _) =>
                              const SizedBox(width: 12),
                          itemBuilder: (context, index) {
                            final product = recommendations[index];
                            return SizedBox(
                              width: 160,
                              child: ProductCard(
                                id: product.id,
                                name: product.name,
                                categoryName: product.categoryName,
                                price: product.price,
                                imageUrl: product.imageUrl,
                                onTap: () => context.push(
                                  '/shop/${product.id}',
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 28),

                  // Staff section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Naše osoblje',
                        style: AppTextStyles.heading3,
                      ),
                      GestureDetector(
                        onTap: () => context.push('/staff'),
                        child: Text(
                          'Vidi sve',
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.accent,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  staffAsync.when(
                    loading: () => SizedBox(
                      height: 210,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: 3,
                        separatorBuilder: (_, _) => const SizedBox(width: 12),
                        itemBuilder: (_, _) => const SizedBox(
                          width: 150,
                          child: StaffCardSkeleton(),
                        ),
                      ),
                    ),
                    error: (_, _) => Text(
                      'Nije moguće učitati osoblje.',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textHint,
                      ),
                    ),
                    data: (staff) {
                      if (staff.isEmpty) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Text(
                            'Nema osoblja za prikaz.',
                            style: AppTextStyles.bodySmall.copyWith(
                              color: AppColors.textHint,
                            ),
                          ),
                        );
                      }

                      return SizedBox(
                        height: 210,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: staff.length,
                          separatorBuilder: (_, _) =>
                              const SizedBox(width: 12),
                          itemBuilder: (context, index) {
                            final member = staff[index];
                            return SizedBox(
                              width: 150,
                              child: StaffCard(
                                id: member.id,
                                firstName: member.firstName,
                                lastName: member.lastName,
                                staffType: member.staffType,
                                profileImageUrl: member.profileImageUrl,
                                onTap: () => context.push(
                                  '/staff/${member.id}',
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

String _formatDate(DateTime date) => DateFormat('dd.MM.yyyy.').format(date);
