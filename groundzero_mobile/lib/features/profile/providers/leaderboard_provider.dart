import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/profile_repository.dart';
import '../models/leaderboard_entry_model.dart';

class LeaderboardState {
  final List<LeaderboardEntryModel> entries;
  final bool isLoading;
  final bool hasMore;
  final int currentPage;

  const LeaderboardState({
    this.entries = const [],
    this.isLoading = false,
    this.hasMore = true,
    this.currentPage = 0,
  });

  LeaderboardState copyWith({
    List<LeaderboardEntryModel>? entries,
    bool? isLoading,
    bool? hasMore,
    int? currentPage,
  }) {
    return LeaderboardState(
      entries: entries ?? this.entries,
      isLoading: isLoading ?? this.isLoading,
      hasMore: hasMore ?? this.hasMore,
      currentPage: currentPage ?? this.currentPage,
    );
  }
}

final leaderboardNotifierProvider =
    NotifierProvider<LeaderboardNotifier, LeaderboardState>(
  LeaderboardNotifier.new,
);

class LeaderboardNotifier extends Notifier<LeaderboardState> {
  static const _pageSize = 20;

  @override
  LeaderboardState build() {
    Future.microtask(() => loadInitial());
    return const LeaderboardState(isLoading: true);
  }

  Future<void> loadInitial() async {
    state = state.copyWith(
      isLoading: true,
      entries: [],
      currentPage: 0,
      hasMore: true,
    );

    try {
      final repo = ref.read(profileRepositoryProvider);
      final result = await repo.getLeaderboard(
        pageNumber: 1,
        pageSize: _pageSize,
      );

      state = state.copyWith(
        entries: result.items,
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
      final repo = ref.read(profileRepositoryProvider);
      final nextPage = state.currentPage + 1;
      final result = await repo.getLeaderboard(
        pageNumber: nextPage,
        pageSize: _pageSize,
      );

      state = state.copyWith(
        entries: [...state.entries, ...result.items],
        isLoading: false,
        currentPage: nextPage,
        hasMore: result.hasNextPage,
      );
    } catch (_) {
      state = state.copyWith(isLoading: false);
    }
  }
}
