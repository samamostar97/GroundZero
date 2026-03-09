import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../core/constants/app_colors.dart';
import '../../../shared/widgets/app_shell.dart';
import '../../appointments/providers/appointments_provider.dart';
import '../../gym_visits/providers/checkin_provider.dart';
import '../../memberships/providers/active_memberships_provider.dart';
import '../../orders/providers/orders_provider.dart';
import '../../products/providers/products_provider.dart';
import '../models/activity_feed_item.dart';
import '../providers/dashboard_provider.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(dashboardNotifierProvider);

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Text(
            'Dashboard',
            style: GoogleFonts.barlowCondensed(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Pregled stanja teretane',
            style: GoogleFonts.inter(
              fontSize: 13,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 24),

          // KPI cards — all clickable
          Row(
            children: [
              _StatCard(
                label: 'Trenutno u teretani',
                value: state.data?.currentlyInGym.toString() ?? '—',
                icon: Icons.fitness_center_rounded,
                accentBorder: (state.data?.currentlyInGym ?? 0) > 0,
                onTap: () {
                  ref.read(sidebarIndexProvider.notifier).state = 2;
                  ref.read(tabIndexProvider.notifier).state = 2;
                  ref.read(checkinNotifierProvider.notifier).loadActive();
                },
              ),
              const SizedBox(width: 16),
              _StatCard(
                label: 'Nizak stock proizvoda',
                value: state.data?.lowStockProductCount.toString() ?? '—',
                icon: Icons.inventory_2_rounded,
                showIndicator: (state.data?.lowStockProductCount ?? 0) > 0,
                onTap: () {
                  ref.read(sidebarIndexProvider.notifier).state = 1;
                  ref.read(tabIndexProvider.notifier).state = 2;
                  ref.read(productsNotifierProvider.notifier).loadPage(1);
                },
              ),
              const SizedBox(width: 16),
              _StatCard(
                label: 'Termini na čekanju',
                value: state.data?.pendingAppointmentCount.toString() ?? '—',
                icon: Icons.calendar_today_rounded,
                showIndicator: (state.data?.pendingAppointmentCount ?? 0) > 0,
                onTap: () {
                  ref.read(sidebarIndexProvider.notifier).state = 2;
                  ref.read(tabIndexProvider.notifier).state = 1;
                  ref.read(appointmentsNotifierProvider.notifier).switchView(excludeStatuses: const {2, 3});
                },
              ),
              const SizedBox(width: 16),
              _StatCard(
                label: 'Pristigle narudžbe',
                value: state.data?.pendingOrders.length.toString() ?? '—',
                icon: Icons.shopping_bag_rounded,
                showIndicator: (state.data?.pendingOrders.length ?? 0) > 0,
                onTap: () {
                  ref.read(sidebarIndexProvider.notifier).state = 2;
                  ref.read(tabIndexProvider.notifier).state = 0;
                  ref.read(ordersNotifierProvider.notifier).switchView(excludeStatuses: const {3, 4});
                },
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Activity feed
          if (state.isLoading && state.data == null)
            const Expanded(
              child: Center(
                child: CircularProgressIndicator(color: AppColors.accent),
              ),
            )
          else if (state.error != null && state.data == null)
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.error_outline_rounded,
                        size: 40, color: AppColors.error),
                    const SizedBox(height: 12),
                    Text(
                      state.error!,
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => ref
                          .read(dashboardNotifierProvider.notifier)
                          .loadData(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.accent,
                        foregroundColor: AppColors.onAccent,
                      ),
                      child: const Text('Pokušaj ponovo'),
                    ),
                  ],
                ),
              ),
            )
          else
            Expanded(child: _buildActivityFeed(state)),
        ],
      ),
    );
  }

  Widget _buildActivityFeed(DashboardState state) {
    final feed = state.activityFeed;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.border, width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.history_rounded, size: 18, color: AppColors.accent),
              const SizedBox(width: 8),
              Text(
                'Posljednja aktivnost',
                style: GoogleFonts.inter(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              const Spacer(),
              if (state.isLoading && state.data != null)
                const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: AppColors.accent,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: feed.isEmpty
                ? Center(
                    child: Text(
                      'Nema nedavne aktivnosti.',
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        color: AppColors.textHint,
                      ),
                    ),
                  )
                : ListView.separated(
                    itemCount: feed.length,
                    separatorBuilder: (_, __) =>
                        Divider(color: AppColors.border, height: 1),
                    itemBuilder: (context, index) =>
                        _ActivityFeedTile(item: feed[index]),
                  ),
          ),
        ],
      ),
    );
  }
}

class _ActivityFeedTile extends StatelessWidget {
  final ActivityFeedItem item;

  const _ActivityFeedTile({required this.item});

  @override
  Widget build(BuildContext context) {
    final timeStr = _formatTimestamp(item.timestamp);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: _iconColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(_icon, size: 16, color: _iconColor),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              item.message,
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: AppColors.textPrimary,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 12),
          Text(
            timeStr,
            style: GoogleFonts.inter(
              fontSize: 11,
              color: AppColors.textHint,
            ),
          ),
        ],
      ),
    );
  }

  IconData get _icon {
    switch (item.type) {
      case 'CheckIn':
        return Icons.login_rounded;
      case 'CheckOut':
        return Icons.logout_rounded;
      case 'Order':
        return Icons.shopping_bag_rounded;
      case 'Appointment':
        return Icons.calendar_today_rounded;
      case 'Registration':
        return Icons.person_add_rounded;
      default:
        return Icons.info_rounded;
    }
  }

  Color get _iconColor {
    switch (item.type) {
      case 'CheckIn':
        return AppColors.success;
      case 'CheckOut':
        return AppColors.textSecondary;
      case 'Order':
        return AppColors.warning;
      case 'Appointment':
        return AppColors.accent;
      case 'Registration':
        return AppColors.accent;
      default:
        return AppColors.textHint;
    }
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final local = timestamp.toLocal();
    final diff = now.difference(local);

    if (diff.inMinutes < 1) return 'upravo';
    if (diff.inMinutes < 60) return 'prije ${diff.inMinutes} min';
    if (diff.inHours < 24) return 'prije ${diff.inHours}h';
    if (diff.inDays < 2) return 'jučer ${DateFormat('HH:mm').format(local)}';
    return DateFormat('dd.MM. HH:mm').format(local);
  }
}

class _StatCard extends StatefulWidget {
  final String label;
  final String value;
  final IconData icon;
  final bool showIndicator;
  final bool accentBorder;
  final VoidCallback? onTap;

  const _StatCard({
    required this.label,
    required this.value,
    required this.icon,
    this.showIndicator = false,
    this.accentBorder = false,
    this.onTap,
  });

  @override
  State<_StatCard> createState() => _StatCardState();
}

class _StatCardState extends State<_StatCard>
    with TickerProviderStateMixin {
  bool _hovered = false;
  AnimationController? _pulseController;
  AnimationController? _borderController;

  @override
  void initState() {
    super.initState();
    _initPulse();
    _initBorderAnimation();
  }

  @override
  void didUpdateWidget(covariant _StatCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.showIndicator != oldWidget.showIndicator) {
      _initPulse();
    }
    if (widget.accentBorder != oldWidget.accentBorder) {
      _initBorderAnimation();
    }
  }

  void _initPulse() {
    if (widget.showIndicator) {
      _pulseController ??= AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 1200),
      )..repeat(reverse: true);
    } else {
      _pulseController?.dispose();
      _pulseController = null;
    }
  }

  void _initBorderAnimation() {
    if (widget.accentBorder) {
      _borderController ??= AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 2000),
      )..repeat(reverse: true);
    } else {
      _borderController?.dispose();
      _borderController = null;
    }
  }

  @override
  void dispose() {
    _pulseController?.dispose();
    _borderController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final card = Expanded(
      child: MouseRegion(
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() => _hovered = false),
        cursor: widget.onTap != null
            ? SystemMouseCursors.click
            : SystemMouseCursors.basic,
        child: GestureDetector(
          onTap: widget.onTap,
          child: _buildCardBody(),
        ),
      ),
    );
    return card;
  }

  Widget _buildCardBody() {
    if (widget.accentBorder && _borderController != null) {
      return AnimatedBuilder(
        animation: _borderController!,
        builder: (context, child) {
          final opacity = 0.15 + (_borderController!.value * 0.25);
          return Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: _hovered ? AppColors.surfaceHigh : AppColors.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: _hovered
                    ? AppColors.success.withValues(alpha: 0.5)
                    : AppColors.success.withValues(alpha: opacity),
                width: 1,
              ),
            ),
            child: _buildCardContent(),
          );
        },
      );
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _hovered ? AppColors.surfaceHigh : AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: _hovered
              ? AppColors.accent.withValues(alpha: 0.3)
              : AppColors.border,
          width: 0.5,
        ),
      ),
      child: _buildCardContent(),
    );
  }

  Widget _buildCardContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Accent top line + blinking indicator
        Row(
          children: [
            Container(
              width: 32,
              height: 3,
              decoration: BoxDecoration(
                color: AppColors.accent,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            if (widget.showIndicator && _pulseController != null) ...[
              const Spacer(),
              FadeTransition(
                opacity: _pulseController!,
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: AppColors.warning,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.warning.withValues(alpha: 0.4),
                        blurRadius: 6,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: 14),
        Icon(widget.icon, color: AppColors.accent, size: 20),
        const SizedBox(height: 12),
        Text(
          widget.value,
          style: GoogleFonts.barlowCondensed(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Expanded(
              child: Text(
                widget.label,
                style: GoogleFonts.inter(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                ),
              ),
            ),
            if (widget.onTap != null)
              Icon(
                Icons.arrow_forward_rounded,
                size: 14,
                color: AppColors.textHint,
              ),
          ],
        ),
      ],
    );
  }
}
