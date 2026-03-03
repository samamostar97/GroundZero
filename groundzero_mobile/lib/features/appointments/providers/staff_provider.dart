import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/staff_repository.dart';
import '../models/staff_model.dart';
import '../models/time_slot_model.dart';

// --- Staff List (paginated, with search + type filter) ---

class StaffListState {
  final List<StaffModel> staff;
  final bool isLoading;
  final bool hasMore;
  final int currentPage;
  final String? search;
  final String? staffType;

  const StaffListState({
    this.staff = const [],
    this.isLoading = false,
    this.hasMore = true,
    this.currentPage = 0,
    this.search,
    this.staffType,
  });

  StaffListState copyWith({
    List<StaffModel>? staff,
    bool? isLoading,
    bool? hasMore,
    int? currentPage,
    String? Function()? search,
    String? Function()? staffType,
  }) {
    return StaffListState(
      staff: staff ?? this.staff,
      isLoading: isLoading ?? this.isLoading,
      hasMore: hasMore ?? this.hasMore,
      currentPage: currentPage ?? this.currentPage,
      search: search != null ? search() : this.search,
      staffType: staffType != null ? staffType() : this.staffType,
    );
  }
}

final staffListNotifierProvider =
    NotifierProvider<StaffListNotifier, StaffListState>(
  StaffListNotifier.new,
);

class StaffListNotifier extends Notifier<StaffListState> {
  static const _pageSize = 10;

  @override
  StaffListState build() {
    Future.microtask(() => loadInitial());
    return const StaffListState(isLoading: true);
  }

  Future<void> loadInitial() async {
    state = state.copyWith(
      isLoading: true,
      staff: [],
      currentPage: 0,
      hasMore: true,
    );

    try {
      final repo = ref.read(staffRepositoryProvider);
      final result = await repo.getStaff(
        pageNumber: 1,
        pageSize: _pageSize,
        search: state.search,
        staffType: state.staffType,
      );

      state = state.copyWith(
        staff: result.items,
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
      final repo = ref.read(staffRepositoryProvider);
      final nextPage = state.currentPage + 1;
      final result = await repo.getStaff(
        pageNumber: nextPage,
        pageSize: _pageSize,
        search: state.search,
        staffType: state.staffType,
      );

      state = state.copyWith(
        staff: [...state.staff, ...result.items],
        isLoading: false,
        currentPage: nextPage,
        hasMore: result.hasNextPage,
      );
    } catch (_) {
      state = state.copyWith(isLoading: false);
    }
  }

  void setSearch(String? search) {
    final value = (search != null && search.isEmpty) ? null : search;
    state = state.copyWith(search: () => value);
    loadInitial();
  }

  void setStaffType(String? staffType) {
    state = state.copyWith(staffType: () => staffType);
    loadInitial();
  }
}

// --- Staff Detail ---

final staffDetailProvider =
    FutureProvider.family<StaffModel, int>((ref, staffId) {
  final repo = ref.watch(staffRepositoryProvider);
  return repo.getStaffById(staffId);
});

// --- Featured Staff (for home screen — first page, no filter) ---

final featuredStaffProvider = FutureProvider<List<StaffModel>>((ref) async {
  final repo = ref.watch(staffRepositoryProvider);
  final result = await repo.getStaff(pageNumber: 1, pageSize: 5);
  return result.items;
});

// --- Available Slots ---

final availableSlotsProvider = FutureProvider.family<List<TimeSlotModel>,
    ({int staffId, DateTime date})>((ref, params) {
  final repo = ref.watch(staffRepositoryProvider);
  return repo.getAvailableSlots(params.staffId, params.date);
});
