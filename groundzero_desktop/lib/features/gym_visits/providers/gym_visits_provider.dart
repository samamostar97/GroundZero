import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_exception.dart';
import '../data/gym_visits_repository.dart';
import '../models/gym_visit_model.dart';

class GymVisitsState {
  final List<GymVisitModel> visits;
  final bool isLoading;
  final String? error;
  final int currentPage;
  final int totalPages;
  final int totalCount;
  final String search;
  final String? sortBy;
  final bool sortDescending;

  const GymVisitsState({
    this.visits = const [],
    this.isLoading = false,
    this.error,
    this.currentPage = 1,
    this.totalPages = 1,
    this.totalCount = 0,
    this.search = '',
    this.sortBy,
    this.sortDescending = true,
  });

  GymVisitsState copyWith({
    List<GymVisitModel>? visits,
    bool? isLoading,
    String? error,
    int? currentPage,
    int? totalPages,
    int? totalCount,
    String? search,
    String? sortBy,
    bool clearSortBy = false,
    bool? sortDescending,
  }) {
    return GymVisitsState(
      visits: visits ?? this.visits,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
      totalCount: totalCount ?? this.totalCount,
      search: search ?? this.search,
      sortBy: clearSortBy ? null : (sortBy ?? this.sortBy),
      sortDescending: sortDescending ?? this.sortDescending,
    );
  }
}

final gymVisitsNotifierProvider =
    NotifierProvider<GymVisitsNotifier, GymVisitsState>(
        GymVisitsNotifier.new);

class GymVisitsNotifier extends Notifier<GymVisitsState> {
  static const _pageSize = 10;

  late final GymVisitsRepository _repository;

  @override
  GymVisitsState build() {
    _repository = ref.watch(gymVisitsRepositoryProvider);
    Future.microtask(() => loadPage(1));
    return const GymVisitsState(isLoading: true);
  }

  Future<void> loadPage(int page) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final result = await _repository.getVisits(
        pageNumber: page,
        pageSize: _pageSize,
        search: state.search,
        sortBy: state.sortBy,
        sortDescending: state.sortBy != null ? state.sortDescending : null,
      );

      state = state.copyWith(
        visits: result.items,
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
        error: 'Greška pri učitavanju posjeta.',
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

  void refresh() => loadPage(state.currentPage);
}
