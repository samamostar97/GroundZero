import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_exception.dart';
import '../data/membership_plans_repository.dart';
import '../models/membership_plan_model.dart';

class MembershipPlansState {
  final List<MembershipPlanModel> plans;
  final bool isLoading;
  final String? error;
  final String search;
  final bool? activeFilter;

  const MembershipPlansState({
    this.plans = const [],
    this.isLoading = false,
    this.error,
    this.search = '',
    this.activeFilter,
  });

  List<MembershipPlanModel> get filtered {
    var result = plans;
    if (activeFilter != null) {
      result = result.where((p) => p.isActive == activeFilter).toList();
    }
    if (search.isNotEmpty) {
      final query = search.toLowerCase();
      result = result
          .where((p) =>
              p.name.toLowerCase().contains(query) ||
              (p.description?.toLowerCase().contains(query) ?? false))
          .toList();
    }
    return result;
  }

  MembershipPlansState copyWith({
    List<MembershipPlanModel>? plans,
    bool? isLoading,
    String? error,
    String? search,
    bool? activeFilter,
    bool clearActiveFilter = false,
  }) {
    return MembershipPlansState(
      plans: plans ?? this.plans,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      search: search ?? this.search,
      activeFilter:
          clearActiveFilter ? null : (activeFilter ?? this.activeFilter),
    );
  }
}

final membershipPlansNotifierProvider =
    NotifierProvider<MembershipPlansNotifier, MembershipPlansState>(
        MembershipPlansNotifier.new);

class MembershipPlansNotifier extends Notifier<MembershipPlansState> {
  late final MembershipPlansRepository _repository;

  @override
  MembershipPlansState build() {
    _repository = ref.watch(membershipPlansRepositoryProvider);
    Future.microtask(() => load());
    return const MembershipPlansState(isLoading: true);
  }

  Future<void> load() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final plans = await _repository.getAll();
      state = state.copyWith(plans: plans, isLoading: false);
    } on ApiException catch (e) {
      state = state.copyWith(isLoading: false, error: e.firstError);
    } catch (_) {
      state = state.copyWith(
        isLoading: false,
        error: 'Greška pri učitavanju planova članarina.',
      );
    }
  }

  void setSearch(String search) {
    state = state.copyWith(search: search);
  }

  void setActiveFilter(bool? isActive) {
    state = state.copyWith(
      activeFilter: isActive,
      clearActiveFilter: isActive == null,
    );
  }

  Future<void> createPlan(Map<String, dynamic> data) async {
    await _repository.create(data);
    await load();
  }

  Future<void> updatePlan(int id, Map<String, dynamic> data) async {
    await _repository.update(id, data);
    await load();
  }

  Future<void> deletePlan(int id) async {
    await _repository.delete(id);
    await load();
  }

  void refresh() => load();
}
