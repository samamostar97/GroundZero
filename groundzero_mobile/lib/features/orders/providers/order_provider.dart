import 'package:flutter/material.dart' show ThemeMode;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import '../../../core/network/api_exception.dart';

import '../data/order_repository.dart';
import '../models/create_order_request.dart';
import '../models/order_item_request.dart';
import '../models/order_model.dart';
import 'cart_provider.dart';

// --- Create Order (with Stripe Payment) ---

sealed class CreateOrderState {
  const CreateOrderState();
}

class CreateOrderIdle extends CreateOrderState {
  const CreateOrderIdle();
}

class CreateOrderLoading extends CreateOrderState {
  const CreateOrderLoading();
}

class CreateOrderSuccess extends CreateOrderState {
  final OrderModel order;
  const CreateOrderSuccess(this.order);
}

class CreateOrderError extends CreateOrderState {
  final String message;
  const CreateOrderError(this.message);
}

final createOrderProvider =
    NotifierProvider<CreateOrderNotifier, CreateOrderState>(
  CreateOrderNotifier.new,
);

class CreateOrderNotifier extends Notifier<CreateOrderState> {
  @override
  CreateOrderState build() {
    return const CreateOrderIdle();
  }

  Future<void> placeOrder() async {
    final cart = ref.read(cartNotifierProvider);
    if (cart.items.isEmpty) return;

    state = const CreateOrderLoading();

    try {
      final repo = ref.read(orderRepositoryProvider);

      // 1. Create order on API → get stripeClientSecret
      final request = CreateOrderRequest(
        items: cart.items
            .map((item) => OrderItemRequest(
                  productId: item.product.id,
                  quantity: item.quantity,
                ))
            .toList(),
      );

      final order = await repo.createOrder(request);

      if (order.stripeClientSecret == null) {
        state = const CreateOrderError(
          'Greška pri kreiranju plaćanja. Pokušajte ponovo.',
        );
        return;
      }

      // 2. Initialize Stripe PaymentSheet
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: order.stripeClientSecret!,
          merchantDisplayName: 'GroundZero',
          style: ThemeMode.dark,
        ),
      );

      // 3. Present PaymentSheet
      await Stripe.instance.presentPaymentSheet();

      // 4. Success — clear cart
      ref.read(cartNotifierProvider.notifier).clear();

      // Invalidate my orders so they refresh
      ref.invalidate(myOrdersNotifierProvider);

      state = CreateOrderSuccess(order);
    } on StripeException catch (e) {
      if (e.error.code == FailureCode.Canceled) {
        // User cancelled — go back to idle
        state = const CreateOrderIdle();
      } else {
        state = CreateOrderError(
          e.error.localizedMessage ?? 'Plaćanje nije uspjelo.',
        );
      }
    } catch (e) {
      state = CreateOrderError(
        e is ApiException
            ? e.firstError
            : 'Neočekivana greška. Pokušajte ponovo.',
      );
    }
  }

  void reset() {
    state = const CreateOrderIdle();
  }
}

// --- My Orders (paginated) ---

class MyOrdersState {
  final List<OrderModel> orders;
  final bool isLoading;
  final bool hasMore;
  final int currentPage;

  const MyOrdersState({
    this.orders = const [],
    this.isLoading = false,
    this.hasMore = true,
    this.currentPage = 0,
  });

  MyOrdersState copyWith({
    List<OrderModel>? orders,
    bool? isLoading,
    bool? hasMore,
    int? currentPage,
  }) {
    return MyOrdersState(
      orders: orders ?? this.orders,
      isLoading: isLoading ?? this.isLoading,
      hasMore: hasMore ?? this.hasMore,
      currentPage: currentPage ?? this.currentPage,
    );
  }
}

final myOrdersNotifierProvider =
    NotifierProvider<MyOrdersNotifier, MyOrdersState>(
  MyOrdersNotifier.new,
);

class MyOrdersNotifier extends Notifier<MyOrdersState> {
  static const _pageSize = 10;

  @override
  MyOrdersState build() {
    Future.microtask(() => loadInitial());
    return const MyOrdersState(isLoading: true);
  }

  Future<void> loadInitial() async {
    state = state.copyWith(
      isLoading: true,
      orders: [],
      currentPage: 0,
      hasMore: true,
    );

    try {
      final repo = ref.read(orderRepositoryProvider);
      final result = await repo.getMyOrders(
        pageNumber: 1,
        pageSize: _pageSize,
      );

      state = state.copyWith(
        orders: result.items,
        isLoading: false,
        currentPage: 1,
        hasMore: result.hasNextPage,
      );
    } catch (_) {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> loadMore() async {
    if (state.isLoading || !state.hasMore) return;

    state = state.copyWith(isLoading: true);

    try {
      final repo = ref.read(orderRepositoryProvider);
      final nextPage = state.currentPage + 1;
      final result = await repo.getMyOrders(
        pageNumber: nextPage,
        pageSize: _pageSize,
      );

      state = state.copyWith(
        orders: [...state.orders, ...result.items],
        isLoading: false,
        currentPage: nextPage,
        hasMore: result.hasNextPage,
      );
    } catch (_) {
      state = state.copyWith(isLoading: false);
    }
  }
}

// --- Order Detail ---

final orderDetailProvider =
    FutureProvider.family<OrderModel, int>((ref, orderId) {
  final repo = ref.watch(orderRepositoryProvider);
  return repo.getOrderById(orderId);
});
