import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_exception.dart';
import '../../gym_visits/data/gym_visits_repository.dart';
import '../../orders/data/orders_repository.dart';
import '../data/dashboard_repository.dart';
import '../models/dashboard_model.dart';

class DashboardState {
  final DashboardModel? data;
  final bool isLoading;
  final bool isActionLoading;
  final String? error;

  const DashboardState({
    this.data,
    this.isLoading = false,
    this.isActionLoading = false,
    this.error,
  });

  DashboardState copyWith({
    DashboardModel? data,
    bool? isLoading,
    bool? isActionLoading,
    String? error,
    bool clearError = false,
  }) {
    return DashboardState(
      data: data ?? this.data,
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
  late final GymVisitsRepository _gymVisitsRepo;
  late final OrdersRepository _ordersRepo;

  Timer? _pollTimer;

  @override
  DashboardState build() {
    _dashboardRepo = ref.watch(dashboardRepositoryProvider);
    _gymVisitsRepo = ref.watch(gymVisitsRepositoryProvider);
    _ordersRepo = ref.watch(ordersRepositoryProvider);
    Future.microtask(() => loadData());

    // Poll every 30 seconds for fresh data
    _pollTimer?.cancel();
    _pollTimer = Timer.periodic(const Duration(seconds: 30), (_) => _refresh());

    ref.onDispose(() => _pollTimer?.cancel());

    return const DashboardState(isLoading: true);
  }

  Future<void> _refresh() async {
    try {
      final data = await _dashboardRepo.getDashboard();
      state = state.copyWith(data: data);
    } catch (_) {
      // Silent refresh — don't show error on background poll
    }
  }

  Future<void> loadData() async {
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      final data = await _dashboardRepo.getDashboard();
      state = state.copyWith(data: data, isLoading: false);
    } on ApiException catch (e) {
      state = state.copyWith(isLoading: false, error: e.firstError);
    } catch (_) {
      state = state.copyWith(
        isLoading: false,
        error: 'Greška pri učitavanju dashboard podataka.',
      );
    }
  }

  Future<String?> checkIn(int userId) async {
    state = state.copyWith(isActionLoading: true, clearError: true);
    try {
      await _gymVisitsRepo.checkIn(userId);
      state = state.copyWith(isActionLoading: false);
      await loadData();
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
      await _gymVisitsRepo.checkOut(userId);
      state = state.copyWith(isActionLoading: false);
      await loadData();
      return null;
    } on ApiException catch (e) {
      state = state.copyWith(isActionLoading: false);
      return e.firstError;
    } catch (_) {
      state = state.copyWith(isActionLoading: false);
      return 'Greška pri odjavi korisnika.';
    }
  }

  Future<String?> confirmOrder(int orderId) async {
    state = state.copyWith(isActionLoading: true, clearError: true);
    try {
      await _ordersRepo.updateStatus(orderId, 1); // Confirmed
      state = state.copyWith(isActionLoading: false);
      await loadData();
      return null;
    } on ApiException catch (e) {
      state = state.copyWith(isActionLoading: false);
      return e.firstError;
    } catch (_) {
      state = state.copyWith(isActionLoading: false);
      return 'Greška pri potvrdi narudžbe.';
    }
  }

  Future<String?> cancelOrder(int orderId) async {
    state = state.copyWith(isActionLoading: true, clearError: true);
    try {
      await _ordersRepo.updateStatus(orderId, 4); // Cancelled
      state = state.copyWith(isActionLoading: false);
      await loadData();
      return null;
    } on ApiException catch (e) {
      state = state.copyWith(isActionLoading: false);
      return e.firstError;
    } catch (_) {
      state = state.copyWith(isActionLoading: false);
      return 'Greška pri otkazivanju narudžbe.';
    }
  }
}
