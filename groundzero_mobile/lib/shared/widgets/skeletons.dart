import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_shadows.dart';
import 'shimmer_loading.dart';

// ─── GamificationCard Skeleton ──────────────────────────────────────────────

class GamificationCardSkeleton extends StatelessWidget {
  const GamificationCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ShimmerLoading(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surfaceLow,
          borderRadius: BorderRadius.circular(12),
          boxShadow: AppShadows.card,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const ShimmerBox(width: 60, height: 26, borderRadius: 8),
                const SizedBox(width: 8),
                const ShimmerBox(width: 80, height: 16),
                const Spacer(),
                const ShimmerBox(width: 50, height: 16),
              ],
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                const ShimmerBox(width: 50, height: 14),
                const Spacer(),
                const ShimmerBox(width: 60, height: 14),
              ],
            ),
            const SizedBox(height: 6),
            const ShimmerBox(width: double.infinity, height: 6, borderRadius: 4),
            const SizedBox(height: 14),
            const ShimmerBox(width: 140, height: 14),
          ],
        ),
      ),
    );
  }
}

// ─── ProductCard Skeleton ───────────────────────────────────────────────────

class ProductCardSkeleton extends StatelessWidget {
  const ProductCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ShimmerLoading(
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surfaceLow,
          borderRadius: BorderRadius.circular(12),
          boxShadow: AppShadows.card,
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(color: const Color(0xFF121212)),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const ShimmerBox(width: 60, height: 18, borderRadius: 6),
                  const SizedBox(height: 6),
                  const ShimmerBox(width: 100, height: 14),
                  const SizedBox(height: 4),
                  const ShimmerBox(width: 70, height: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── StaffCard Skeleton ─────────────────────────────────────────────────────

class StaffCardSkeleton extends StatelessWidget {
  const StaffCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ShimmerLoading(
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surfaceLow,
          borderRadius: BorderRadius.circular(12),
          boxShadow: AppShadows.card,
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Container(color: const Color(0xFF121212)),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  const ShimmerBox(width: 70, height: 18, borderRadius: 6),
                  const SizedBox(height: 6),
                  const ShimmerBox(width: 100, height: 14),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── OrderListTile Skeleton ─────────────────────────────────────────────────

class OrderListTileSkeleton extends StatelessWidget {
  const OrderListTileSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ShimmerLoading(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surfaceLow,
          borderRadius: BorderRadius.circular(12),
          boxShadow: AppShadows.card,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const ShimmerBox(width: 110, height: 16),
                const ShimmerBox(width: 70, height: 22, borderRadius: 6),
              ],
            ),
            const SizedBox(height: 8),
            const ShimmerBox(width: 80, height: 14),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const ShimmerBox(width: 80, height: 16),
                const ShimmerBox(width: 90, height: 14),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ─── AppointmentListTile Skeleton ───────────────────────────────────────────

class AppointmentListTileSkeleton extends StatelessWidget {
  const AppointmentListTileSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ShimmerLoading(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surfaceLow,
          borderRadius: BorderRadius.circular(12),
          boxShadow: AppShadows.card,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const ShimmerBox(width: 130, height: 16),
                const ShimmerBox(width: 70, height: 22, borderRadius: 6),
              ],
            ),
            const SizedBox(height: 8),
            const ShimmerBox(width: 80, height: 14),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const ShimmerBox(width: 150, height: 14),
                const ShimmerBox(width: 50, height: 14),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ─── LeaderboardTile Skeleton ───────────────────────────────────────────────

class LeaderboardTileSkeleton extends StatelessWidget {
  const LeaderboardTileSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ShimmerLoading(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.surfaceLow,
          borderRadius: BorderRadius.circular(10),
          boxShadow: AppShadows.card,
        ),
        child: Row(
          children: [
            const ShimmerBox(width: 30, height: 16),
            const SizedBox(width: 6),
            const ShimmerCircle(size: 40),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const ShimmerBox(width: 120, height: 14),
                  const SizedBox(height: 4),
                  const ShimmerBox(width: 90, height: 12),
                ],
              ),
            ),
            const ShimmerBox(width: 60, height: 16),
          ],
        ),
      ),
    );
  }
}

// ─── WorkoutPlanCard Skeleton ───────────────────────────────────────────────

class WorkoutPlanCardSkeleton extends StatelessWidget {
  const WorkoutPlanCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ShimmerLoading(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surfaceLow,
          borderRadius: BorderRadius.circular(12),
          boxShadow: AppShadows.card,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ShimmerBox(width: 160, height: 16),
            const SizedBox(height: 6),
            const ShimmerBox(width: double.infinity, height: 14),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const ShimmerBox(width: 70, height: 14),
                const ShimmerBox(width: 80, height: 14),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ─── ProductDetail Skeleton ─────────────────────────────────────────────────

class ProductDetailSkeleton extends StatelessWidget {
  const ProductDetailSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ShimmerLoading(
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        children: [
          // Image placeholder
          AspectRatio(
            aspectRatio: 1,
            child: Container(color: const Color(0xFF121212)),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ShimmerBox(width: 80, height: 24, borderRadius: 8),
                const SizedBox(height: 12),
                const ShimmerBox(width: 200, height: 24),
                const SizedBox(height: 8),
                const ShimmerBox(width: 100, height: 24),
                const SizedBox(height: 8),
                const ShimmerBox(width: 130, height: 16),
                const SizedBox(height: 16),
                const ShimmerBox(width: double.infinity, height: 14),
                const SizedBox(height: 6),
                const ShimmerBox(width: double.infinity, height: 14),
                const SizedBox(height: 6),
                const ShimmerBox(width: 200, height: 14),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── StaffDetail Skeleton ───────────────────────────────────────────────────

class StaffDetailSkeleton extends StatelessWidget {
  const StaffDetailSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ShimmerLoading(
      child: ListView(
        padding: const EdgeInsets.all(20),
        physics: const NeverScrollableScrollPhysics(),
        children: [
          // Avatar
          const Center(child: ShimmerBox(width: 160, height: 160, borderRadius: 16)),
          const SizedBox(height: 20),
          // Name
          const Center(child: ShimmerBox(width: 180, height: 24)),
          const SizedBox(height: 8),
          // Type badge
          const Center(child: ShimmerBox(width: 90, height: 24, borderRadius: 8)),
          const SizedBox(height: 24),
          // Info card
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.surfaceLow,
              borderRadius: BorderRadius.circular(12),
              boxShadow: AppShadows.card,
            ),
            child: const Column(
              children: [
                ShimmerBox(width: double.infinity, height: 14),
                SizedBox(height: 10),
                ShimmerBox(width: double.infinity, height: 14),
              ],
            ),
          ),
          const SizedBox(height: 20),
          // Bio section
          const ShimmerBox(width: 100, height: 20),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.surfaceLow,
              borderRadius: BorderRadius.circular(12),
              boxShadow: AppShadows.card,
            ),
            child: const Column(
              children: [
                ShimmerBox(width: double.infinity, height: 14),
                SizedBox(height: 6),
                ShimmerBox(width: double.infinity, height: 14),
                SizedBox(height: 6),
                ShimmerBox(width: 200, height: 14),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── AppointmentDetail Skeleton ─────────────────────────────────────────────

class AppointmentDetailSkeleton extends StatelessWidget {
  const AppointmentDetailSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ShimmerLoading(
      child: ListView(
        padding: const EdgeInsets.all(20),
        physics: const NeverScrollableScrollPhysics(),
        children: [
          // Status section
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.surfaceLow,
              borderRadius: BorderRadius.circular(12),
              boxShadow: AppShadows.card,
            ),
            child: const ShimmerBox(width: double.infinity, height: 20),
          ),
          const SizedBox(height: 20),
          // Staff info
          const ShimmerBox(width: 80, height: 20),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.surfaceLow,
              borderRadius: BorderRadius.circular(12),
              boxShadow: AppShadows.card,
            ),
            child: const Column(
              children: [
                ShimmerBox(width: double.infinity, height: 14),
                SizedBox(height: 10),
                ShimmerBox(width: double.infinity, height: 14),
              ],
            ),
          ),
          const SizedBox(height: 20),
          // Info section
          const ShimmerBox(width: 100, height: 20),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.surfaceLow,
              borderRadius: BorderRadius.circular(12),
              boxShadow: AppShadows.card,
            ),
            child: const Column(
              children: [
                ShimmerBox(width: double.infinity, height: 14),
                SizedBox(height: 10),
                ShimmerBox(width: double.infinity, height: 14),
                SizedBox(height: 10),
                ShimmerBox(width: double.infinity, height: 14),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── OrderDetail Skeleton ───────────────────────────────────────────────────

class OrderDetailSkeleton extends StatelessWidget {
  const OrderDetailSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ShimmerLoading(
      child: ListView(
        padding: const EdgeInsets.all(20),
        physics: const NeverScrollableScrollPhysics(),
        children: [
          // Status timeline
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.surfaceLow,
              borderRadius: BorderRadius.circular(12),
              boxShadow: AppShadows.card,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                4,
                (_) => const Column(
                  children: [
                    ShimmerCircle(size: 36),
                    SizedBox(height: 6),
                    ShimmerBox(width: 50, height: 10),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          // Order info card
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.surfaceLow,
              borderRadius: BorderRadius.circular(12),
              boxShadow: AppShadows.card,
            ),
            child: const Column(
              children: [
                ShimmerBox(width: double.infinity, height: 14),
                SizedBox(height: 8),
                ShimmerBox(width: double.infinity, height: 14),
                SizedBox(height: 8),
                ShimmerBox(width: double.infinity, height: 14),
              ],
            ),
          ),
          const SizedBox(height: 20),
          // Items header
          const ShimmerBox(width: 60, height: 20),
          const SizedBox(height: 12),
          // Item tiles
          for (int i = 0; i < 3; i++) ...[
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.surfaceLow,
                borderRadius: BorderRadius.circular(10),
                boxShadow: AppShadows.card,
              ),
              child: const Row(
                children: [
                  ShimmerBox(width: 56, height: 56, borderRadius: 8),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ShimmerBox(width: 120, height: 14),
                        SizedBox(height: 4),
                        ShimmerBox(width: 80, height: 12),
                      ],
                    ),
                  ),
                  ShimmerBox(width: 70, height: 16),
                ],
              ),
            ),
            if (i < 2) const SizedBox(height: 10),
          ],
        ],
      ),
    );
  }
}

// ─── WorkoutPlanDetail Skeleton ─────────────────────────────────────────────

class WorkoutPlanDetailSkeleton extends StatelessWidget {
  const WorkoutPlanDetailSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ShimmerLoading(
      child: ListView(
        padding: const EdgeInsets.all(20),
        physics: const NeverScrollableScrollPhysics(),
        children: [
          // Plan info card
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.surfaceLow,
              borderRadius: BorderRadius.circular(12),
              boxShadow: AppShadows.card,
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShimmerBox(width: 180, height: 20),
                SizedBox(height: 8),
                ShimmerBox(width: double.infinity, height: 14),
                SizedBox(height: 4),
                ShimmerBox(width: 200, height: 14),
              ],
            ),
          ),
          const SizedBox(height: 24),
          // Days header
          const ShimmerBox(width: 120, height: 20),
          const SizedBox(height: 14),
          // Day cards
          for (int i = 0; i < 3; i++) ...[
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.surfaceLow,
                borderRadius: BorderRadius.circular(12),
                boxShadow: AppShadows.card,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const ShimmerBox(width: 140, height: 16),
                  const SizedBox(height: 10),
                  const ShimmerBox(width: double.infinity, height: 14),
                  const SizedBox(height: 6),
                  const ShimmerBox(width: double.infinity, height: 14),
                ],
              ),
            ),
            if (i < 2) const SizedBox(height: 12),
          ],
        ],
      ),
    );
  }
}

// ─── Profile Skeleton ───────────────────────────────────────────────────────

class ProfileSkeleton extends StatelessWidget {
  const ProfileSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ShimmerLoading(
      child: ListView(
        padding: const EdgeInsets.all(20),
        physics: const NeverScrollableScrollPhysics(),
        children: [
          const SizedBox(height: 10),
          // Avatar
          const Center(child: ShimmerCircle(size: 96)),
          const SizedBox(height: 16),
          // Name
          const Center(child: ShimmerBox(width: 160, height: 24)),
          const SizedBox(height: 4),
          // Email
          const Center(child: ShimmerBox(width: 200, height: 14)),
          const SizedBox(height: 24),
          // Gamification card
          const GamificationCardSkeleton(),
          const SizedBox(height: 24),
          // Menu items
          for (int i = 0; i < 5; i++) ...[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: AppColors.surfaceLow,
                borderRadius: BorderRadius.circular(10),
                boxShadow: AppShadows.card,
              ),
              child: const Row(
                children: [
                  ShimmerBox(width: 22, height: 22),
                  SizedBox(width: 14),
                  ShimmerBox(width: 120, height: 14),
                ],
              ),
            ),
            if (i < 4) const SizedBox(height: 10),
          ],
        ],
      ),
    );
  }
}
