import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_exception.dart';
import '../data/categories_repository.dart';
import '../models/category_model.dart';

class CategoriesState {
  final List<CategoryModel> categories;
  final bool isLoading;
  final String? error;
  final String search;

  const CategoriesState({
    this.categories = const [],
    this.isLoading = false,
    this.error,
    this.search = '',
  });

  List<CategoryModel> get filtered {
    if (search.isEmpty) return categories;
    final query = search.toLowerCase();
    return categories
        .where((c) =>
            c.name.toLowerCase().contains(query) ||
            (c.description?.toLowerCase().contains(query) ?? false))
        .toList();
  }

  CategoriesState copyWith({
    List<CategoryModel>? categories,
    bool? isLoading,
    String? error,
    String? search,
  }) {
    return CategoriesState(
      categories: categories ?? this.categories,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      search: search ?? this.search,
    );
  }
}

final categoriesNotifierProvider =
    NotifierProvider<CategoriesNotifier, CategoriesState>(
        CategoriesNotifier.new);

class CategoriesNotifier extends Notifier<CategoriesState> {
  late final CategoriesRepository _repository;

  @override
  CategoriesState build() {
    _repository = ref.watch(categoriesRepositoryProvider);
    Future.microtask(() => load());
    return const CategoriesState(isLoading: true);
  }

  Future<void> load() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final categories = await _repository.getAll();
      state = state.copyWith(categories: categories, isLoading: false);
    } on ApiException catch (e) {
      state = state.copyWith(isLoading: false, error: e.firstError);
    } catch (_) {
      state = state.copyWith(
        isLoading: false,
        error: 'Greška pri učitavanju kategorija.',
      );
    }
  }

  void setSearch(String search) {
    state = state.copyWith(search: search);
  }

  Future<void> createCategory(Map<String, dynamic> data) async {
    await _repository.create(data);
    await load();
  }

  Future<void> updateCategory(int id, Map<String, dynamic> data) async {
    await _repository.update(id, data);
    await load();
  }

  Future<void> deleteCategory(int id) async {
    await _repository.delete(id);
    await load();
  }

  void refresh() => load();
}
