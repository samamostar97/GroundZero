import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/utils/image_utils.dart';
import '../../../shared/widgets/error_display.dart';
import '../../../shared/widgets/order_status_badge.dart';
import '../../../shared/widgets/skeletons.dart';
import '../models/order_item_model.dart';
import '../models/order_model.dart';
import '../providers/order_provider.dart';

class OrderDetailScreen extends ConsumerWidget {
  final int orderId;

  const OrderDetailScreen({super.key, required this.orderId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orderAsync = ref.watch(orderDetailProvider(orderId));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: orderAsync.whenOrNull(
          data: (order) => Text(
            'Narudžba #${order.id}',
            style: AppTextStyles.heading3,
          ),
        ),
      ),
      body: orderAsync.when(
        loading: () => const OrderDetailSkeleton(),
        error: (_, _) => ErrorDisplay(
          message: 'Greška pri učitavanju narudžbe.',
          onRetry: () => ref.invalidate(orderDetailProvider(orderId)),
        ),
        data: (order) => ListView(
          padding: const EdgeInsets.all(20),
          children: [
            // Status timeline
            _StatusTimeline(currentStatus: order.status),
            const SizedBox(height: 24),

            // Order info card
            _OrderInfoCard(order: order),
            const SizedBox(height: 20),

            // Items header
            Text('Stavke', style: AppTextStyles.heading3),
            const SizedBox(height: 12),

            // Items list
            ...order.items.map(
              (item) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: _OrderItemTile(item: item),
              ),
            ),
            const SizedBox(height: 16),

            // Total
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.border),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Ukupno',
                    style: AppTextStyles.heading3,
                  ),
                  Text(
                    '${order.totalAmount.toStringAsFixed(2)} KM',
                    style: AppTextStyles.heading2.copyWith(
                      color: AppColors.accent,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatusTimeline extends StatelessWidget {
  final int currentStatus;

  const _StatusTimeline({required this.currentStatus});

  static const _steps = [
    (0, 'Na čekanju', Icons.hourglass_empty_rounded),
    (1, 'Potvrđeno', Icons.check_circle_outline_rounded),
    (2, 'Poslano', Icons.local_shipping_outlined),
    (3, 'Dostavljeno', Icons.inventory_2_outlined),
  ];

  @override
  Widget build(BuildContext context) {
    // If cancelled, show special state
    if (currentStatus == 4) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.error.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.error.withValues(alpha: 0.3)),
        ),
        child: Row(
          children: [
            const Icon(Icons.cancel_outlined, color: AppColors.error),
            const SizedBox(width: 12),
            Text(
              'Narudžba je otkazana',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.error,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _steps.map((step) {
          final (statusValue, label, icon) = step;
          final isActive = currentStatus >= statusValue;
          final isCurrent = currentStatus == statusValue;

          return Expanded(
            child: Column(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: isActive
                        ? AppColors.accent.withValues(alpha: isCurrent ? 1.0 : 0.3)
                        : AppColors.inputFill,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    icon,
                    size: 18,
                    color: isActive
                        ? (isCurrent ? AppColors.onAccent : AppColors.accent)
                        : AppColors.textHint,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  label,
                  style: AppTextStyles.bodySmall.copyWith(
                    fontSize: 10,
                    color: isActive ? AppColors.textPrimary : AppColors.textHint,
                    fontWeight: isCurrent ? FontWeight.w600 : FontWeight.normal,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _OrderInfoCard extends StatelessWidget {
  final OrderModel order;

  const _OrderInfoCard({required this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          _InfoRow(
            label: 'Datum',
            value: _formatDateTime(order.createdAt),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Status',
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              OrderStatusBadge(status: order.status),
            ],
          ),
          const SizedBox(height: 8),
          _InfoRow(
            label: 'Stavke',
            value: '${order.items.length}',
          ),
        ],
      ),
    );
  }

  String _formatDateTime(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year}. '
        '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        Text(
          value,
          style: AppTextStyles.bodyMedium.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _OrderItemTile extends StatelessWidget {
  final OrderItemModel item;

  const _OrderItemTile({required this.item});

  @override
  Widget build(BuildContext context) {
    final imageUrl = ImageUtils.fullImageUrl(item.productImageUrl);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          // Product image
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: SizedBox(
              width: 56,
              height: 56,
              child: imageUrl != null
                  ? CachedNetworkImage(
                      imageUrl: imageUrl,
                      fit: BoxFit.cover,
                      placeholder: (_, _) => Container(
                        color: AppColors.inputFill,
                      ),
                      errorWidget: (_, _, _) => Container(
                        color: AppColors.inputFill,
                        child: const Icon(
                          Icons.fitness_center,
                          color: AppColors.textHint,
                          size: 22,
                        ),
                      ),
                    )
                  : Container(
                      color: AppColors.inputFill,
                      child: const Icon(
                        Icons.fitness_center,
                        color: AppColors.textHint,
                        size: 22,
                      ),
                    ),
            ),
          ),
          const SizedBox(width: 12),

          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.productName,
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  '${item.quantity} x ${item.unitPrice.toStringAsFixed(2)} KM',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),

          // Subtotal
          Text(
            '${item.subtotal.toStringAsFixed(2)} KM',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.accent,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
