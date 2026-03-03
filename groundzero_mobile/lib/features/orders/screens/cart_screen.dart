import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../shared/widgets/cart_item_tile.dart';
import '../../../shared/widgets/empty_state.dart';
import '../providers/cart_provider.dart';
import '../providers/order_provider.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(cartNotifierProvider);
    final createOrderState = ref.watch(createOrderProvider);

    // Listen for order result
    ref.listen<CreateOrderState>(createOrderProvider, (prev, next) {
      if (next is CreateOrderSuccess) {
        context.go('/order-confirmation/${next.order.id}');
      } else if (next is CreateOrderError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.message),
            backgroundColor: AppColors.error,
          ),
        );
      }
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Korpa', style: AppTextStyles.heading3),
      ),
      body: cart.items.isEmpty
          ? Center(
              child: EmptyState(
                icon: Icons.shopping_cart_outlined,
                message: 'Vaša korpa je prazna.',
                actionLabel: 'Pogledajte shop',
                onAction: () => context.go('/shop'),
              ),
            )
          : Column(
              children: [
                // Cart items list
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.all(20),
                    itemCount: cart.items.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final item = cart.items[index];
                      return CartItemTile(
                        item: item,
                        onQuantityChanged: (qty) {
                          ref
                              .read(cartNotifierProvider.notifier)
                              .updateQuantity(item.product.id, qty);
                        },
                        onRemove: () {
                          ref
                              .read(cartNotifierProvider.notifier)
                              .removeItem(item.product.id);
                        },
                      );
                    },
                  ),
                ),

                // Bottom bar with total and order button
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    color: AppColors.surface,
                    border: Border(
                      top: BorderSide(color: AppColors.border),
                    ),
                  ),
                  child: SafeArea(
                    top: false,
                    child: Column(
                      children: [
                        // Total
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Ukupno',
                              style: AppTextStyles.bodyMedium.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                            Text(
                              '${cart.totalAmount.toStringAsFixed(2)} KM',
                              style: AppTextStyles.heading2.copyWith(
                                color: AppColors.accent,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // Order button
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: createOrderState is CreateOrderLoading
                                ? null
                                : () {
                                    ref
                                        .read(createOrderProvider.notifier)
                                        .placeOrder();
                                  },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.accent,
                              foregroundColor: AppColors.onAccent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: createOrderState is CreateOrderLoading
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: AppColors.onAccent,
                                    ),
                                  )
                                : Text('Naruči', style: AppTextStyles.button),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
