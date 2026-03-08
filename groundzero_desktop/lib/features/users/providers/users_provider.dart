import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_exception.dart';
import '../data/users_repository.dart';
import '../models/user_model.dart';

// State
class UsersState {
  final List<UserModel> users;
  final bool isLoading;
  final String? error;
  final int currentPage;
  final int totalPages;
  final int totalCount;
  final String search;
  final String? sortBy;
  final bool sortDescending;

  const UsersState({
    this.users = const [],
    this.isLoading = false,
    this.error,
    this.currentPage = 1,
    this.totalPages = 1,
    this.totalCount = 0,
    this.search = '',
    this.sortBy,
    this.sortDescending = true,
  });

  UsersState copyWith({
    List<UserModel>? users,
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
    return UsersState(
      users: users ?? this.users,
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

// Provider
final usersNotifierProvider =
    NotifierProvider<UsersNotifier, UsersState>(UsersNotifier.new);

class UsersNotifier extends Notifier<UsersState> {
  static const _pageSize = 10;

  late final UsersRepository _repository;

  @override
  UsersState build() {
    _repository = ref.watch(usersRepositoryProvider);
    // Auto-load on first build
    Future.microtask(() => loadPage(1));
    return const UsersState(isLoading: true);
  }

  Future<void> loadPage(int page) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final result = await _repository.getUsers(
        pageNumber: page,
        pageSize: _pageSize,
        search: state.search,
        sortBy: state.sortBy,
        sortDescending: state.sortBy != null ? state.sortDescending : null,
      );

      state = state.copyWith(
        users: result.items,
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
        error: 'Greška pri učitavanju korisnika.',
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

  Future<void> deleteUser(int id) async {
    try {
      await _repository.deleteUser(id);
      // Reload current page
      await loadPage(state.currentPage);
    } on ApiException catch (e) {
      state = state.copyWith(error: e.firstError);
    }
  }

  void refresh() => loadPage(state.currentPage);
}
