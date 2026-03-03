import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_shadows.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../shared/widgets/error_display.dart';
import '../models/membership_plan_model.dart';
import '../models/user_membership_model.dart';
import '../providers/membership_provider.dart';

class MembershipScreen extends ConsumerWidget {
  const MembershipScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final membershipAsync = ref.watch(currentMembershipProvider);
    final plansAsync = ref.watch(membershipPlansProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Članstvo', style: AppTextStyles.heading3),
        backgroundColor: AppColors.background,
        surfaceTintColor: Colors.transparent,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // Current membership
          Text('Aktivna članarina', style: AppTextStyles.heading3),
          const SizedBox(height: 12),
          membershipAsync.when(
            loading: () => _buildLoadingCard(),
            error: (e, _) => ErrorDisplay(
              message: 'Greška pri učitavanju članarine.',
              onRetry: () => ref.invalidate(currentMembershipProvider),
            ),
            data: (membership) => membership != null && membership.status == 'Active'
                ? _ActiveMembershipCard(membership: membership)
                : _buildEmptyState(),
          ),
          const SizedBox(height: 32),

          // Available plans
          Text('Dostupni planovi', style: AppTextStyles.heading3),
          const SizedBox(height: 12),
          plansAsync.when(
            loading: () => _buildLoadingCard(),
            error: (e, _) => ErrorDisplay(
              message: 'Greška pri učitavanju planova.',
              onRetry: () => ref.invalidate(membershipPlansProvider),
            ),
            data: (plans) => Column(
              children: plans.map((plan) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: _PlanCard(plan: plan),
              )).toList(),
            ),
          ),
          const SizedBox(height: 32),

          // History
          Text('Historija', style: AppTextStyles.heading3),
          const SizedBox(height: 12),
          membershipAsync.when(
            loading: () => const SizedBox.shrink(),
            error: (_, _) => const SizedBox.shrink(),
            data: (membership) {
              if (membership != null && membership.status != 'Active') {
                return _HistoryItem(membership: membership);
              }
              return Text(
                'Još nemate prethodnih članarina.',
                style: AppTextStyles.bodySmall,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingCard() {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Center(
        child: CircularProgressIndicator(color: AppColors.accent),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: AppShadows.card,
      ),
      child: Column(
        children: [
          Icon(
            Icons.card_membership_rounded,
            color: AppColors.textHint,
            size: 48,
          ),
          const SizedBox(height: 12),
          Text(
            'Nemate aktivnu članarinu',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Obratite se na recepciju za aktivaciju.',
            style: AppTextStyles.bodySmall,
          ),
        ],
      ),
    );
  }
}

class _ActiveMembershipCard extends StatelessWidget {
  final UserMembershipModel membership;

  const _ActiveMembershipCard({required this.membership});

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd.MM.yyyy.');
    final daysRemaining = membership.endDate.difference(DateTime.now()).inDays;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: AppShadows.accentGlow,
        border: Border.all(color: AppColors.accent.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.accent,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  'AKTIVNA',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.onAccent,
                    fontWeight: FontWeight.w700,
                    fontSize: 11,
                  ),
                ),
              ),
              const Spacer(),
              Text(
                '${membership.planPrice.toStringAsFixed(0)} KM',
                style: AppTextStyles.heading3.copyWith(
                  color: AppColors.accent,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            membership.planName,
            style: AppTextStyles.heading2,
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.calendar_today_rounded, color: AppColors.textHint, size: 16),
              const SizedBox(width: 6),
              Text(
                '${dateFormat.format(membership.startDate)} — ${dateFormat.format(membership.endDate)}',
                style: AppTextStyles.bodySmall,
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Days remaining bar
          Row(
            children: [
              Icon(Icons.timer_outlined, color: AppColors.accent, size: 16),
              const SizedBox(width: 6),
              Text(
                'Još $daysRemaining ${_daysLabel(daysRemaining)}',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.accent,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(3),
            child: LinearProgressIndicator(
              value: _calculateProgress(),
              backgroundColor: AppColors.inputFill,
              valueColor: const AlwaysStoppedAnimation<Color>(AppColors.accent),
              minHeight: 6,
            ),
          ),
        ],
      ),
    );
  }

  double _calculateProgress() {
    final total = membership.endDate.difference(membership.startDate).inDays;
    final elapsed = DateTime.now().difference(membership.startDate).inDays;
    if (total <= 0) return 1.0;
    return (elapsed / total).clamp(0.0, 1.0);
  }

  String _daysLabel(int days) {
    if (days == 1) return 'dan';
    if (days >= 2 && days <= 4) return 'dana';
    return 'dana';
  }
}

class _PlanCard extends StatelessWidget {
  final MembershipPlanModel plan;

  const _PlanCard({required this.plan});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: AppShadows.card,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  plan.name,
                  style: AppTextStyles.bodyLarge.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (plan.description != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    plan.description!,
                    style: AppTextStyles.bodySmall,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
                const SizedBox(height: 6),
                Text(
                  '${plan.durationDays} dana',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textHint,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Column(
            children: [
              Text(
                plan.price.toStringAsFixed(0),
                style: AppTextStyles.heading2.copyWith(
                  color: AppColors.accent,
                ),
              ),
              Text(
                'KM',
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.accent,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _HistoryItem extends StatelessWidget {
  final UserMembershipModel membership;

  const _HistoryItem({required this.membership});

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd.MM.yyyy.');
    final isExpired = membership.status == 'Expired';
    final isCancelled = membership.status == 'Cancelled';

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(10),
        boxShadow: AppShadows.card,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  membership.planName,
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${dateFormat.format(membership.startDate)} — ${dateFormat.format(membership.endDate)}',
                  style: AppTextStyles.bodySmall,
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: isExpired
                  ? AppColors.textHint.withValues(alpha: 0.2)
                  : isCancelled
                      ? AppColors.error.withValues(alpha: 0.2)
                      : AppColors.accent.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              isExpired ? 'Istekla' : isCancelled ? 'Otkazana' : 'Aktivna',
              style: AppTextStyles.bodySmall.copyWith(
                color: isExpired
                    ? AppColors.textHint
                    : isCancelled
                        ? AppColors.error
                        : AppColors.accent,
                fontWeight: FontWeight.w600,
                fontSize: 11,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
