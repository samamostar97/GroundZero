import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_exception.dart';
import '../data/memberships_repository.dart';
import '../models/membership_model.dart';

class ActiveMembershipsState {
  final List<MembershipModel> memberships;
  final bool isLoading;
  final bool isActionLoading;
  final String? error;
  final String search;

  ActiveMembershipsState({
    this.memberships = const [],
    this.isLoading = false,
    this.isActionLoading = false,
    this.error,
    this.search = '',
  });

  ActiveMembershipsState copyWith({
    List<MembershipModel>? memberships,
    bool? isLoading,
    bool? isActionLoading,
    String? error,
    bool clearError = false,
    String? search,
  }) {
    return ActiveMembershipsState(
      memberships: memberships ?? this.memberships,
      isLoading: isLoading ?? this.isLoading,
      isActionLoading: isActionLoading ?? this.isActionLoading,
      error: clearError ? null : (error ?? this.error),
      search: search ?? this.search,
    );
  }

  List<MembershipModel> get filteredMemberships {
    if (search.isEmpty) return memberships;
    final searchLower = search.toLowerCase();
    return memberships
        .where((m) =>
            m.userFullName.toLowerCase().contains(searchLower) ||
            m.userEmail.toLowerCase().contains(searchLower) ||
            m.planName.toLowerCase().contains(searchLower))
        .toList();
  }
}

final activeMembershipsNotifierProvider =
    NotifierProvider<ActiveMembershipsNotifier, ActiveMembershipsState>(
        ActiveMembershipsNotifier.new);

class ActiveMembershipsNotifier extends Notifier<ActiveMembershipsState> {
  late final MembershipsRepository _repository;

  @override
  ActiveMembershipsState build() {
    _repository = ref.watch(membershipsRepositoryProvider);
    Future.microtask(() => loadActive());
    return ActiveMembershipsState(isLoading: true);
  }

  Future<void> loadActive() async {
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      // Fetch all active memberships (no pagination — small dataset)
      final result = await _repository.getMemberships(
        pageNumber: 1,
        pageSize: 200,
        status: 'Active',
      );
      state = state.copyWith(
        memberships: result.items,
        isLoading: false,
      );
    } on ApiException catch (e) {
      state = state.copyWith(isLoading: false, error: e.firstError);
    } catch (_) {
      state = state.copyWith(
        isLoading: false,
        error: 'Greška pri učitavanju aktivnih članarina.',
      );
    }
  }

  void setSearch(String search) {
    state = state.copyWith(search: search);
  }

  Future<void> assign(Map<String, dynamic> data) async {
    await _repository.assign(data);
    await loadActive();
  }

  Future<String?> cancel(int id) async {
    state = state.copyWith(isActionLoading: true, clearError: true);
    try {
      await _repository.cancel(id);
      state = state.copyWith(isActionLoading: false);
      await loadActive();
      return null;
    } on ApiException catch (e) {
      state = state.copyWith(isActionLoading: false);
      return e.firstError;
    } catch (_) {
      state = state.copyWith(isActionLoading: false);
      return 'Greška pri otkazivanju članarine.';
    }
  }
}
