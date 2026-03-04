import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_exception.dart';
import '../data/orders_repository.dart';
import '../models/order_model.dart';

class OrdersState {
  final List<OrderModel> orders;
  final bool isLoading;
  final String? error;
  final int currentPage;
  final int totalPages;
  final int totalCount;
  final String search;
  final int? statusFilter;

  const OrdersState({
    this.orders = const [],
    this.isLoading = false,
    this.error,
    this.currentPage = 1,
    this.totalPages = 1,
    this.totalCount = 0,
    this.search = '',
    this.statusFilter,
  });

  OrdersState copyWith({
    List<OrderModel>? orders,
    bool? isLoading,
    String? error,
    int? currentPage,
    int? totalPages,
    int? totalCount,
    String? search,
    int? statusFilter,
    bool clearStatusFilter = false,
  }) {
    return OrdersState(
      orders: orders ?? this.orders,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
      totalCount: totalCount ?? this.totalCount,
      search: search ?? this.search,
      statusFilter:
          clearStatusFilter ? null : (statusFilter ?? this.statusFilter),
    );
  }
}

final ordersNotifierProvider =
    NotifierProvider<OrdersNotifier, OrdersState>(OrdersNotifier.new);

class OrdersNotifier extends Notifier<OrdersState> {
  static const _pageSize = 10;

  late final OrdersRepository _repository;

  @override
  OrdersState build() {
    _repository = ref.watch(ordersRepositoryProvider);
    Future.microtask(() => loadPage(1));
    return const OrdersState(isLoading: true);
  }

  Future<void> loadPage(int page) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final result = await _repository.getOrders(
        pageNumber: page,
        pageSize: _pageSize,
        search: state.search,
        status: state.statusFilter,
      );

      state = state.copyWith(
        orders: result.items,
        isLoading: false,
        currentPage: result.pageNumber,
        totalPages: result.totalPages,
        totalCount: result.totalCount,
      );
    } on ApiException catch (e) {
      state = state.copyWith(isLoading: false, error: e.firstError);
    } catch (_) {
      state = state.copyWith(
        isLoading: false,
        error: 'Greška pri učitavanju narudžbi.',
      );
    }
  }

  void setSearch(String search) {
    state = state.copyWith(search: search);
    loadPage(1);
  }

  void setStatusFilter(int? status) {
    state = state.copyWith(
      statusFilter: status,
      clearStatusFilter: status == null,
    );
    loadPage(1);
  }

  Future<String?> updateStatus(int id, int status) async {
    try {
      await _repository.updateStatus(id, status);
      await loadPage(state.currentPage);
      return null;
    } on ApiException catch (e) {
      return e.firstError;
    }
  }

  void refresh() => loadPage(state.currentPage);
}
