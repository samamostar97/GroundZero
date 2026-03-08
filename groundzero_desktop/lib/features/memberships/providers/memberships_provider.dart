import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_exception.dart';
import '../data/memberships_repository.dart';
import '../models/membership_model.dart';

class MembershipsState {
  final List<MembershipModel> memberships;
  final bool isLoading;
  final String? error;
  final int currentPage;
  final int totalPages;
  final int totalCount;
  final String search;
  final String? statusFilter;
  final String? sortBy;
  final bool sortDescending;

  const MembershipsState({
    this.memberships = const [],
    this.isLoading = false,
    this.error,
    this.currentPage = 1,
    this.totalPages = 1,
    this.totalCount = 0,
    this.search = '',
    this.statusFilter,
    this.sortBy,
    this.sortDescending = true,
  });

  MembershipsState copyWith({
    List<MembershipModel>? memberships,
    bool? isLoading,
    String? error,
    int? currentPage,
    int? totalPages,
    int? totalCount,
    String? search,
    String? statusFilter,
    bool clearStatusFilter = false,
    String? sortBy,
    bool clearSortBy = false,
    bool? sortDescending,
  }) {
    return MembershipsState(
      memberships: memberships ?? this.memberships,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
      totalCount: totalCount ?? this.totalCount,
      search: search ?? this.search,
      statusFilter:
          clearStatusFilter ? null : (statusFilter ?? this.statusFilter),
      sortBy: clearSortBy ? null : (sortBy ?? this.sortBy),
      sortDescending: sortDescending ?? this.sortDescending,
    );
  }
}

final membershipsNotifierProvider =
    NotifierProvider<MembershipsNotifier, MembershipsState>(
        MembershipsNotifier.new);

class MembershipsNotifier extends Notifier<MembershipsState> {
  static const _pageSize = 10;

  late final MembershipsRepository _repository;

  @override
  MembershipsState build() {
    _repository = ref.watch(membershipsRepositoryProvider);
    Future.microtask(() => loadPage(1));
    return const MembershipsState(isLoading: true);
  }

  Future<void> loadPage(int page) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final result = await _repository.getMemberships(
        pageNumber: page,
        pageSize: _pageSize,
        search: state.search,
        status: state.statusFilter,
        sortBy: state.sortBy,
        sortDescending: state.sortBy != null ? state.sortDescending : null,
      );

      state = state.copyWith(
        memberships: result.items,
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
        error: 'Greška pri učitavanju članarina.',
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

  void setStatusFilter(String? status) {
    state = state.copyWith(
      statusFilter: status,
      clearStatusFilter: status == null,
    );
    loadPage(1);
  }

  Future<void> assign(Map<String, dynamic> data) async {
    await _repository.assign(data);
    await loadPage(1);
  }

  Future<String?> cancel(int id) async {
    try {
      await _repository.cancel(id);
      await loadPage(state.currentPage);
      return null;
    } on ApiException catch (e) {
      return e.firstError;
    }
  }

  void refresh() => loadPage(state.currentPage);
}
