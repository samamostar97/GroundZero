import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../shop/data/review_repository.dart';
import '../../shop/models/review_model.dart';

class StaffReviewsState {
  final List<ReviewModel> reviews;
  final double? averageRating;
  final bool isLoading;
  final bool hasMore;
  final int currentPage;
  final int staffId;

  const StaffReviewsState({
    this.reviews = const [],
    this.averageRating,
    this.isLoading = false,
    this.hasMore = true,
    this.currentPage = 0,
    required this.staffId,
  });

  StaffReviewsState copyWith({
    List<ReviewModel>? reviews,
    double? Function()? averageRating,
    bool? isLoading,
    bool? hasMore,
    int? currentPage,
  }) {
    return StaffReviewsState(
      reviews: reviews ?? this.reviews,
      averageRating:
          averageRating != null ? averageRating() : this.averageRating,
      isLoading: isLoading ?? this.isLoading,
      hasMore: hasMore ?? this.hasMore,
      currentPage: currentPage ?? this.currentPage,
      staffId: staffId,
    );
  }
}

final staffReviewsNotifierProvider = NotifierProvider.autoDispose.family<
    StaffReviewsNotifier, StaffReviewsState, int>(
  StaffReviewsNotifier.new,
);

class StaffReviewsNotifier
    extends AutoDisposeFamilyNotifier<StaffReviewsState, int> {
  static const _pageSize = 10;

  @override
  StaffReviewsState build(int arg) {
    Future.microtask(() => loadInitial());
    return StaffReviewsState(staffId: arg, isLoading: true);
  }

  Future<void> loadInitial() async {
    state = state.copyWith(
      isLoading: true,
      reviews: [],
      currentPage: 0,
      hasMore: true,
    );

    try {
      final repo = ref.read(reviewRepositoryProvider);
      final result = await repo.getStaffReviews(
        state.staffId,
        pageNumber: 1,
        pageSize: _pageSize,
      );

      state = state.copyWith(
        reviews: result.reviews.items,
        averageRating: () => result.averageRating,
        isLoading: false,
        currentPage: 1,
        hasMore: result.reviews.hasNextPage,
      );
    } catch (_) {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> loadMore() async {
    if (state.isLoading || !state.hasMore) return;

    state = state.copyWith(isLoading: true);

    try {
      final repo = ref.read(reviewRepositoryProvider);
      final nextPage = state.currentPage + 1;
      final result = await repo.getStaffReviews(
        state.staffId,
        pageNumber: nextPage,
        pageSize: _pageSize,
      );

      state = state.copyWith(
        reviews: [...state.reviews, ...result.reviews.items],
        isLoading: false,
        currentPage: nextPage,
        hasMore: result.reviews.hasNextPage,
      );
    } catch (_) {
      state = state.copyWith(isLoading: false);
    }
  }
}
