import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/product_repository.dart';
import '../models/product_model.dart';

class ProductsState {
  final List<ProductModel> products;
  final bool isLoading;
  final bool hasMore;
  final int currentPage;
  final String? search;
  final int? categoryId;

  const ProductsState({
    this.products = const [],
    this.isLoading = false,
    this.hasMore = true,
    this.currentPage = 0,
    this.search,
    this.categoryId,
  });

  ProductsState copyWith({
    List<ProductModel>? products,
    bool? isLoading,
    bool? hasMore,
    int? currentPage,
    String? Function()? search,
    int? Function()? categoryId,
  }) {
    return ProductsState(
      products: products ?? this.products,
      isLoading: isLoading ?? this.isLoading,
      hasMore: hasMore ?? this.hasMore,
      currentPage: currentPage ?? this.currentPage,
      search: search != null ? search() : this.search,
      categoryId: categoryId != null ? categoryId() : this.categoryId,
    );
  }
}

final productsNotifierProvider =
    NotifierProvider<ProductsNotifier, ProductsState>(ProductsNotifier.new);

class ProductsNotifier extends Notifier<ProductsState> {
  static const _pageSize = 10;

  @override
  ProductsState build() {
    // Load initial data on build
    Future.microtask(() => loadInitial());
    return const ProductsState(isLoading: true);
  }

  Future<void> loadInitial() async {
    state = state.copyWith(
      isLoading: true,
      products: [],
      currentPage: 0,
      hasMore: true,
    );

    try {
      final repo = ref.read(productRepositoryProvider);
      final result = await repo.getProducts(
        pageNumber: 1,
        pageSize: _pageSize,
        search: state.search,
        categoryId: state.categoryId,
      );

      state = state.copyWith(
        products: result.items,
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
      final repo = ref.read(productRepositoryProvider);
      final nextPage = state.currentPage + 1;
      final result = await repo.getProducts(
        pageNumber: nextPage,
        pageSize: _pageSize,
        search: state.search,
        categoryId: state.categoryId,
      );

      state = state.copyWith(
        products: [...state.products, ...result.items],
        isLoading: false,
        currentPage: nextPage,
        hasMore: result.hasNextPage,
      );
    } catch (_) {
      state = state.copyWith(isLoading: false);
    }
  }

  void setSearch(String? search) {
    final value = (search != null && search.isEmpty) ? null : search;
    state = state.copyWith(search: () => value);
    loadInitial();
  }

  void setCategoryId(int? categoryId) {
    state = state.copyWith(categoryId: () => categoryId);
    loadInitial();
  }
}
