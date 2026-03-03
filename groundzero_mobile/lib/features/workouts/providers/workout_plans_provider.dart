import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_exception.dart';
import '../data/workout_repository.dart';
import '../models/workout_plan_model.dart';

// --- Workout Plans (paginated + search) ---

class WorkoutPlansState {
  final List<WorkoutPlanModel> plans;
  final bool isLoading;
  final bool hasMore;
  final int currentPage;
  final String? search;

  const WorkoutPlansState({
    this.plans = const [],
    this.isLoading = false,
    this.hasMore = true,
    this.currentPage = 0,
    this.search,
  });

  WorkoutPlansState copyWith({
    List<WorkoutPlanModel>? plans,
    bool? isLoading,
    bool? hasMore,
    int? currentPage,
    String? Function()? search,
  }) {
    return WorkoutPlansState(
      plans: plans ?? this.plans,
      isLoading: isLoading ?? this.isLoading,
      hasMore: hasMore ?? this.hasMore,
      currentPage: currentPage ?? this.currentPage,
      search: search != null ? search() : this.search,
    );
  }
}

final workoutPlansNotifierProvider =
    NotifierProvider<WorkoutPlansNotifier, WorkoutPlansState>(
  WorkoutPlansNotifier.new,
);

class WorkoutPlansNotifier extends Notifier<WorkoutPlansState> {
  static const _pageSize = 10;

  @override
  WorkoutPlansState build() {
    Future.microtask(() => loadInitial());
    return const WorkoutPlansState(isLoading: true);
  }

  Future<void> loadInitial() async {
    state = state.copyWith(
      isLoading: true,
      plans: [],
      currentPage: 0,
      hasMore: true,
    );

    try {
      final repo = ref.read(workoutRepositoryProvider);
      final result = await repo.getMyPlans(
        pageNumber: 1,
        pageSize: _pageSize,
        search: state.search,
      );

      state = state.copyWith(
        plans: result.items,
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
      final repo = ref.read(workoutRepositoryProvider);
      final nextPage = state.currentPage + 1;
      final result = await repo.getMyPlans(
        pageNumber: nextPage,
        pageSize: _pageSize,
        search: state.search,
      );

      state = state.copyWith(
        plans: [...state.plans, ...result.items],
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
}

// --- Create Workout Plan ---

sealed class CreateWorkoutPlanState {
  const CreateWorkoutPlanState();
}

class CreateWorkoutPlanIdle extends CreateWorkoutPlanState {
  const CreateWorkoutPlanIdle();
}

class CreateWorkoutPlanLoading extends CreateWorkoutPlanState {
  const CreateWorkoutPlanLoading();
}

class CreateWorkoutPlanSuccess extends CreateWorkoutPlanState {
  final WorkoutPlanModel plan;
  const CreateWorkoutPlanSuccess(this.plan);
}

class CreateWorkoutPlanError extends CreateWorkoutPlanState {
  final String message;
  const CreateWorkoutPlanError(this.message);
}

final createWorkoutPlanProvider =
    NotifierProvider<CreateWorkoutPlanNotifier, CreateWorkoutPlanState>(
  CreateWorkoutPlanNotifier.new,
);

class CreateWorkoutPlanNotifier extends Notifier<CreateWorkoutPlanState> {
  @override
  CreateWorkoutPlanState build() => const CreateWorkoutPlanIdle();

  Future<void> create({required String name, String? description}) async {
    state = const CreateWorkoutPlanLoading();

    try {
      final repo = ref.read(workoutRepositoryProvider);
      final plan = await repo.createPlan(name: name, description: description);

      ref.invalidate(workoutPlansNotifierProvider);

      state = CreateWorkoutPlanSuccess(plan);
    } catch (e) {
      state = CreateWorkoutPlanError(
        e is ApiException
            ? e.firstError
            : 'Neočekivana greška. Pokušajte ponovo.',
      );
    }
  }

  void reset() => state = const CreateWorkoutPlanIdle();
}

// --- Delete Workout Plan ---

sealed class DeleteWorkoutPlanState {
  const DeleteWorkoutPlanState();
}

class DeleteWorkoutPlanIdle extends DeleteWorkoutPlanState {
  const DeleteWorkoutPlanIdle();
}

class DeleteWorkoutPlanLoading extends DeleteWorkoutPlanState {
  const DeleteWorkoutPlanLoading();
}

class DeleteWorkoutPlanSuccess extends DeleteWorkoutPlanState {
  const DeleteWorkoutPlanSuccess();
}

class DeleteWorkoutPlanError extends DeleteWorkoutPlanState {
  final String message;
  const DeleteWorkoutPlanError(this.message);
}

final deleteWorkoutPlanProvider =
    NotifierProvider<DeleteWorkoutPlanNotifier, DeleteWorkoutPlanState>(
  DeleteWorkoutPlanNotifier.new,
);

class DeleteWorkoutPlanNotifier extends Notifier<DeleteWorkoutPlanState> {
  @override
  DeleteWorkoutPlanState build() => const DeleteWorkoutPlanIdle();

  Future<void> delete(int planId) async {
    state = const DeleteWorkoutPlanLoading();

    try {
      final repo = ref.read(workoutRepositoryProvider);
      await repo.deletePlan(planId);

      ref.invalidate(workoutPlansNotifierProvider);

      state = const DeleteWorkoutPlanSuccess();
    } catch (e) {
      state = DeleteWorkoutPlanError(
        e is ApiException
            ? e.firstError
            : 'Neočekivana greška. Pokušajte ponovo.',
      );
    }
  }

  void reset() => state = const DeleteWorkoutPlanIdle();
}
