import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_exception.dart';
import '../data/gym_visits_repository.dart';
import '../models/gym_visit_model.dart';

class CheckinState {
  final List<GymVisitModel> activeVisits;
  final bool isLoading;
  final bool isActionLoading;
  final String? error;
  final String search;
  final int tick; // Incremented every 30s to trigger rebuild for duration updates

  CheckinState({
    this.activeVisits = const [],
    this.isLoading = false,
    this.isActionLoading = false,
    this.error,
    this.search = '',
    this.tick = 0,
  });

  CheckinState copyWith({
    List<GymVisitModel>? activeVisits,
    bool? isLoading,
    bool? isActionLoading,
    String? error,
    bool clearError = false,
    String? search,
    int? tick,
  }) {
    return CheckinState(
      activeVisits: activeVisits ?? this.activeVisits,
      isLoading: isLoading ?? this.isLoading,
      isActionLoading: isActionLoading ?? this.isActionLoading,
      error: clearError ? null : (error ?? this.error),
      search: search ?? this.search,
      tick: tick ?? this.tick,
    );
  }

  List<GymVisitModel> get filteredVisits {
    if (search.isEmpty) return activeVisits;
    final searchLower = search.toLowerCase();
    return activeVisits
        .where((v) => v.userFullName.toLowerCase().contains(searchLower))
        .toList();
  }
}

final checkinNotifierProvider =
    NotifierProvider<CheckinNotifier, CheckinState>(CheckinNotifier.new);

class CheckinNotifier extends Notifier<CheckinState> {
  late final GymVisitsRepository _repository;
  Timer? _tickTimer;

  @override
  CheckinState build() {
    _repository = ref.watch(gymVisitsRepositoryProvider);
    Future.microtask(() => loadActive());

    // Tick every 30s to update durations
    _tickTimer?.cancel();
    _tickTimer = Timer.periodic(
      const Duration(seconds: 30),
      (_) => state = state.copyWith(tick: state.tick + 1),
    );

    ref.onDispose(() => _tickTimer?.cancel());

    return CheckinState(isLoading: true);
  }

  Future<void> loadActive() async {
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      // Fetch all visits, filter active (no checkout) client-side
      // Using page size 100 since active visits are always small
      final result = await _repository.getVisits(
        pageNumber: 1,
        pageSize: 100,
        sortBy: 'checkInAt',
        sortDescending: false,
      );
      final active = result.items.where((v) => v.checkOutAt == null).toList();
      state = state.copyWith(
        activeVisits: active,
        isLoading: false,
      );
    } on ApiException catch (e) {
      state = state.copyWith(isLoading: false, error: e.firstError);
    } catch (_) {
      state = state.copyWith(
        isLoading: false,
        error: 'Greška pri učitavanju aktivnih posjeta.',
      );
    }
  }

  void setSearch(String search) {
    state = state.copyWith(search: search);
  }

  Future<String?> checkIn(int userId) async {
    state = state.copyWith(isActionLoading: true, clearError: true);
    try {
      await _repository.checkIn(userId);
      state = state.copyWith(isActionLoading: false);
      await loadActive();
      return null;
    } on ApiException catch (e) {
      state = state.copyWith(isActionLoading: false);
      return e.firstError;
    } catch (_) {
      state = state.copyWith(isActionLoading: false);
      return 'Greška pri prijavi korisnika.';
    }
  }

  Future<String?> checkOut(int userId) async {
    state = state.copyWith(isActionLoading: true, clearError: true);
    try {
      await _repository.checkOut(userId);
      state = state.copyWith(isActionLoading: false);
      await loadActive();
      return null;
    } on ApiException catch (e) {
      state = state.copyWith(isActionLoading: false);
      return e.firstError;
    } catch (_) {
      state = state.copyWith(isActionLoading: false);
      return 'Greška pri odjavi korisnika.';
    }
  }
}
