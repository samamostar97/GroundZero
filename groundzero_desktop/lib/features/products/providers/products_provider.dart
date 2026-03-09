import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_exception.dart';
import '../data/products_repository.dart';
import '../models/product_model.dart';

class ProductsState {
  final List<ProductModel> products;
  final bool isLoading;
  final String? error;
  final int currentPage;
  final int totalPages;
  final int totalCount;
  final String search;
  final int? categoryFilter;
  final String? sortBy;
  final bool sortDescending;

  const ProductsState({
    this.products = const [],
    this.isLoading = false,
    this.error,
    this.currentPage = 1,
    this.totalPages = 1,
    this.totalCount = 0,
    this.search = '',
    this.categoryFilter,
    this.sortBy = 'stockquantity',
    this.sortDescending = false,
  });

  ProductsState copyWith({
    List<ProductModel>? products,
    bool? isLoading,
    String? error,
    int? currentPage,
    int? totalPages,
    int? totalCount,
    String? search,
    int? categoryFilter,
    bool clearCategoryFilter = false,
    String? sortBy,
    bool clearSortBy = false,
    bool? sortDescending,
  }) {
    return ProductsState(
      products: products ?? this.products,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
      totalCount: totalCount ?? this.totalCount,
      search: search ?? this.search,
      categoryFilter:
          clearCategoryFilter ? null : (categoryFilter ?? this.categoryFilter),
      sortBy: clearSortBy ? null : (sortBy ?? this.sortBy),
      sortDescending: sortDescending ?? this.sortDescending,
    );
  }
}

final productsNotifierProvider =
    NotifierProvider<ProductsNotifier, ProductsState>(ProductsNotifier.new);

class ProductsNotifier extends Notifier<ProductsState> {
  static const _pageSize = 10;

  late final ProductsRepository _repository;

  @override
  ProductsState build() {
    _repository = ref.watch(productsRepositoryProvider);
    Future.microtask(() => loadPage(1));
    return const ProductsState(isLoading: true);
  }

  Future<void> loadPage(int page) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final result = await _repository.getProducts(
        pageNumber: page,
        pageSize: _pageSize,
        search: state.search,
        categoryId: state.categoryFilter,
        sortBy: state.sortBy,
        sortDescending: state.sortBy != null ? state.sortDescending : null,
      );

      state = state.copyWith(
        products: result.items,
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
        error: 'Greška pri učitavanju proizvoda.',
      );
    }
  }

  void setSearch(String search) {
    state = state.copyWith(search: search);
    loadPage(1);
  }

  void setSort(String column) {
    if (state.sortBy == column) {
      state = state.copyWith(sortDescending: !state.sortDescending);
    } else {
      state = state.copyWith(sortBy: column, sortDescending: true);
    }
    loadPage(1);
  }

  void setCategoryFilter(int? categoryId) {
    state = state.copyWith(
      categoryFilter: categoryId,
      clearCategoryFilter: categoryId == null,
    );
    loadPage(1);
  }

  Future<int> createProduct(Map<String, dynamic> data) async {
    final product = await _repository.create(data);
    await loadPage(1);
    return product.id;
  }

  Future<void> updateProduct(int id, Map<String, dynamic> data) async {
    await _repository.update(id, data);
    await loadPage(state.currentPage);
  }

  Future<void> deleteProduct(int id) async {
    await _repository.delete(id);
    await loadPage(state.currentPage);
  }

  void refresh() => loadPage(state.currentPage);
}
