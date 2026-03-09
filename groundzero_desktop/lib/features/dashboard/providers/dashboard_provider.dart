import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_exception.dart';
import '../data/dashboard_repository.dart';
import '../models/activity_feed_item.dart';
import '../models/dashboard_model.dart';

class DashboardState {
  final DashboardModel? data;
  final List<ActivityFeedItem> activityFeed;
  final bool isLoading;
  final bool isActionLoading;
  final String? error;

  const DashboardState({
    this.data,
    this.activityFeed = const [],
    this.isLoading = false,
    this.isActionLoading = false,
    this.error,
  });

  DashboardState copyWith({
    DashboardModel? data,
    List<ActivityFeedItem>? activityFeed,
    bool? isLoading,
    bool? isActionLoading,
    String? error,
    bool clearError = false,
  }) {
    return DashboardState(
      data: data ?? this.data,
      activityFeed: activityFeed ?? this.activityFeed,
      isLoading: isLoading ?? this.isLoading,
      isActionLoading: isActionLoading ?? this.isActionLoading,
      error: clearError ? null : (error ?? this.error),
    );
  }
}

final dashboardNotifierProvider =
    NotifierProvider<DashboardNotifier, DashboardState>(DashboardNotifier.new);

class DashboardNotifier extends Notifier<DashboardState> {
  late final DashboardRepository _dashboardRepo;
  Timer? _pollTimer;

  @override
  DashboardState build() {
    _dashboardRepo = ref.watch(dashboardRepositoryProvider);
    Future.microtask(() => loadData());

    // Poll every 30 seconds for fresh data
    _pollTimer?.cancel();
    _pollTimer = Timer.periodic(const Duration(seconds: 30), (_) => _refresh());

    ref.onDispose(() => _pollTimer?.cancel());

    return const DashboardState(isLoading: true);
  }

  Future<void> _refresh() async {
    try {
      final results = await Future.wait([
        _dashboardRepo.getDashboard(),
        _dashboardRepo.getActivityFeed(),
      ]);
      state = state.copyWith(
        data: results[0] as DashboardModel,
        activityFeed: results[1] as List<ActivityFeedItem>,
      );
    } catch (_) {
      // Silent refresh — don't show error on background poll
    }
  }

  Future<void> loadData() async {
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      final results = await Future.wait([
        _dashboardRepo.getDashboard(),
        _dashboardRepo.getActivityFeed(),
      ]);
      state = state.copyWith(
        data: results[0] as DashboardModel,
        activityFeed: results[1] as List<ActivityFeedItem>,
        isLoading: false,
      );
    } on ApiException catch (e) {
      state = state.copyWith(isLoading: false, error: e.firstError);
    } catch (_) {
      state = state.copyWith(
        isLoading: false,
        error: 'Greška pri učitavanju dashboard podataka.',
      );
    }
  }

}
