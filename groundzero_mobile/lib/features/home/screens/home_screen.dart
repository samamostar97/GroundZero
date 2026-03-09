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
import '../../appointments/providers/appointment_provider.dart';
import '../../appointments/providers/staff_provider.dart';
import '../../auth/providers/user_provider.dart';
import '../../membership/providers/membership_provider.dart';
import '../../profile/providers/gamification_provider.dart';
import '../../shop/providers/recommendations_provider.dart';
import '../../workouts/providers/workout_plans_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(userNotifierProvider);
    final gamificationAsync = ref.watch(gamificationProvider);
    final membershipAsync = ref.watch(currentMembershipProvider);
    final recommendationsAsync = ref.watch(recommendationsProvider);
    final staffAsync = ref.watch(featuredStaffProvider);
    final workoutPlansAsync = ref.watch(homeWorkoutPlansProvider);
    final upcomingAppointment = ref.watch(upcomingAppointmentReminderProvider);

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
                ref.invalidate(homeWorkoutPlansProvider);
                ref.invalidate(upcomingAppointmentReminderProvider);
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
                    error: (_, _) {
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
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.card_membership_rounded,
                                color: AppColors.textHint,
                                size: 22,
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Text(
                                  'Nema aktivne članarine',
                                  style: AppTextStyles.bodyMedium.copyWith(
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
                    },
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

                  // Appointment reminder (only visible if upcoming within 3 days)
                  upcomingAppointment.when(
                    loading: () => const SizedBox.shrink(),
                    error: (_, _) => const SizedBox.shrink(),
                    data: (appointment) {
                      if (appointment == null) return const SizedBox.shrink();

                      final now = DateTime.now();
                      final diff = appointment.scheduledAt.difference(now);
                      final String timeLabel;
                      if (diff.inDays >= 1) {
                        timeLabel = 'za ${diff.inDays} ${diff.inDays == 1 ? 'dan' : 'dana'}';
                      } else if (diff.inHours >= 1) {
                        timeLabel = 'za ${diff.inHours}h';
                      } else {
                        timeLabel = 'uskoro';
                      }

                      return Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: GestureDetector(
                          onTap: () => context.push(
                            '/appointments/${appointment.id}',
                          ),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 14,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.surface,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: AppShadows.card,
                              border: Border.all(
                                color: AppColors.warning.withValues(alpha: 0.3),
                              ),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: AppColors.warning.withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Icon(
                                    Icons.event_rounded,
                                    color: AppColors.warning,
                                    size: 22,
                                  ),
                                ),
                                const SizedBox(width: 14),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Termin $timeLabel',
                                        style: AppTextStyles.bodyMedium.copyWith(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        '${appointment.staffFullName} · ${DateFormat('dd.MM. u HH:mm').format(appointment.scheduledAt)}',
                                        style: AppTextStyles.bodySmall.copyWith(
                                          color: AppColors.textSecondary,
                                        ),
                                      ),
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

                  const SizedBox(height: 28),

                  // Workout plans section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Vaši treninzi',
                        style: AppTextStyles.heading3,
                      ),
                      GestureDetector(
                        onTap: () => _navigateToWorkoutsTab(context),
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
                  workoutPlansAsync.when(
                    loading: () => SizedBox(
                      height: 120,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: 3,
                        separatorBuilder: (_, _) => const SizedBox(width: 12),
                        itemBuilder: (_, _) => Container(
                          width: 200,
                          decoration: BoxDecoration(
                            color: AppColors.surface,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    error: (_, _) => Text(
                      'Nije moguće učitati planove.',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textHint,
                      ),
                    ),
                    data: (plans) {
                      if (plans.isEmpty) {
                        return GestureDetector(
                          onTap: () => _navigateToWorkoutsTab(context),
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 24,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.surface,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: AppShadows.card,
                              border: Border.all(
                                color: AppColors.accent.withValues(alpha: 0.15),
                              ),
                            ),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.fitness_center_rounded,
                                  color: AppColors.accent,
                                  size: 32,
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  'Kreirajte svoj prvi plan treninga',
                                  style: AppTextStyles.bodyMedium.copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Organizirajte vježbe po danima i pratite napredak',
                                  style: AppTextStyles.bodySmall.copyWith(
                                    color: AppColors.textSecondary,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        );
                      }

                      return SizedBox(
                        height: 120,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: plans.length,
                          separatorBuilder: (_, _) =>
                              const SizedBox(width: 12),
                          itemBuilder: (context, index) {
                            final plan = plans[index];
                            final dayCount = plan.days.length;
                            final exerciseCount = plan.days
                                .fold(0, (sum, d) => sum + d.exercises.length);

                            return GestureDetector(
                              onTap: () => context.push(
                                '/workouts/${plan.id}',
                              ),
                              child: Container(
                                width: 200,
                                padding: const EdgeInsets.all(14),
                                decoration: BoxDecoration(
                                  color: AppColors.surface,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: AppShadows.card,
                                ),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.fitness_center_rounded,
                                          color: AppColors.accent,
                                          size: 18,
                                        ),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: Text(
                                            plan.name,
                                            style: AppTextStyles.bodyMedium
                                                .copyWith(
                                              fontWeight: FontWeight.w600,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                    if (plan.description != null &&
                                        plan.description!.isNotEmpty)
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 8),
                                        child: Text(
                                          plan.description!,
                                          style: AppTextStyles.bodySmall
                                              .copyWith(
                                            color: AppColors.textSecondary,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    Row(
                                      children: [
                                        _PlanStat(
                                          icon: Icons.calendar_today_rounded,
                                          label: '$dayCount dana',
                                        ),
                                        const SizedBox(width: 14),
                                        _PlanStat(
                                          icon: Icons.list_rounded,
                                          label: '$exerciseCount vježbi',
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

void _navigateToWorkoutsTab(BuildContext context) {
  // Navigate to Workouts tab (index 2) in the bottom navigation
  final shell = StatefulNavigationShell.maybeOf(context);
  if (shell != null) {
    shell.goBranch(2);
  }
}

String _formatDate(DateTime date) => DateFormat('dd.MM.yyyy.').format(date);

class _PlanStat extends StatelessWidget {
  final IconData icon;
  final String label;

  const _PlanStat({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 13, color: AppColors.textHint),
        const SizedBox(width: 4),
        Text(
          label,
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.textHint,
            fontSize: 11,
          ),
        ),
      ],
    );
  }
}
