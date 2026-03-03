import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_exception.dart';
import '../data/staff_repository.dart';
import '../models/staff_model.dart';

class StaffState {
  final List<StaffModel> staff;
  final bool isLoading;
  final String? error;
  final int currentPage;
  final int totalPages;
  final int totalCount;
  final String search;
  final String? staffTypeFilter;

  const StaffState({
    this.staff = const [],
    this.isLoading = false,
    this.error,
    this.currentPage = 1,
    this.totalPages = 1,
    this.totalCount = 0,
    this.search = '',
    this.staffTypeFilter,
  });

  StaffState copyWith({
    List<StaffModel>? staff,
    bool? isLoading,
    String? error,
    int? currentPage,
    int? totalPages,
    int? totalCount,
    String? search,
    String? staffTypeFilter,
    bool clearStaffTypeFilter = false,
  }) {
    return StaffState(
      staff: staff ?? this.staff,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
      totalCount: totalCount ?? this.totalCount,
      search: search ?? this.search,
      staffTypeFilter:
          clearStaffTypeFilter ? null : (staffTypeFilter ?? this.staffTypeFilter),
    );
  }
}

final staffNotifierProvider =
    NotifierProvider<StaffNotifier, StaffState>(StaffNotifier.new);

class StaffNotifier extends Notifier<StaffState> {
  static const _pageSize = 10;

  late final StaffRepository _repository;

  @override
  StaffState build() {
    _repository = ref.watch(staffRepositoryProvider);
    Future.microtask(() => loadPage(1));
    return const StaffState(isLoading: true);
  }

  Future<void> loadPage(int page) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final result = await _repository.getStaff(
        pageNumber: page,
        pageSize: _pageSize,
        search: state.search,
        staffType: state.staffTypeFilter,
      );

      state = state.copyWith(
        staff: result.items,
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
        error: 'Greška pri učitavanju osoblja.',
      );
    }
  }

  void setSearch(String search) {
    state = state.copyWith(search: search);
    loadPage(1);
  }

  void setStaffTypeFilter(String? type) {
    state = state.copyWith(
      staffTypeFilter: type,
      clearStaffTypeFilter: type == null,
    );
    loadPage(1);
  }

  Future<int> createStaff(Map<String, dynamic> data) async {
    final staff = await _repository.createStaff(data);
    await loadPage(1);
    return staff.id;
  }

  Future<void> updateStaff(int id, Map<String, dynamic> data) async {
    await _repository.updateStaff(id, data);
    await loadPage(state.currentPage);
  }

  Future<void> deleteStaff(int id) async {
    await _repository.deleteStaff(id);
    await loadPage(state.currentPage);
  }

  void refresh() => loadPage(state.currentPage);
}
