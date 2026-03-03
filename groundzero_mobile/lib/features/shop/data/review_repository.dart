import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/models/paged_result.dart';
import '../../../core/network/api_exception.dart';
import '../../../core/network/dio_client.dart';
import '../models/create_review_request.dart';
import '../models/review_model.dart';
import '../models/update_review_request.dart';

class ReviewsWithRating {
  final double? averageRating;
  final PagedResult<ReviewModel> reviews;

  const ReviewsWithRating({
    required this.averageRating,
    required this.reviews,
  });
}

final reviewRepositoryProvider = Provider<ReviewRepository>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return ReviewRepository(dioClient.dio);
});

class ReviewRepository {
  final Dio _dio;

  ReviewRepository(this._dio);

  Future<ReviewsWithRating> getProductReviews(
    int productId, {
    int pageNumber = 1,
    int pageSize = 10,
  }) async {
    try {
      final response = await _dio.get(
        ApiConstants.productReviews(productId),
        queryParameters: {
          'pageNumber': pageNumber,
          'pageSize': pageSize,
        },
      );
      final data = response.data as Map<String, dynamic>;
      return ReviewsWithRating(
        averageRating: data['averageRating'] != null
            ? (data['averageRating'] as num).toDouble()
            : null,
        reviews: PagedResult.fromJson(
          data['reviews'] as Map<String, dynamic>,
          (json) => ReviewModel.fromJson(json),
        ),
      );
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<ReviewsWithRating> getStaffReviews(
    int staffId, {
    int pageNumber = 1,
    int pageSize = 10,
  }) async {
    try {
      final response = await _dio.get(
        ApiConstants.staffReviews(staffId),
        queryParameters: {
          'pageNumber': pageNumber,
          'pageSize': pageSize,
        },
      );
      final data = response.data as Map<String, dynamic>;
      return ReviewsWithRating(
        averageRating: data['averageRating'] != null
            ? (data['averageRating'] as num).toDouble()
            : null,
        reviews: PagedResult.fromJson(
          data['reviews'] as Map<String, dynamic>,
          (json) => ReviewModel.fromJson(json),
        ),
      );
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<ReviewModel> createReview(CreateReviewRequest request) async {
    try {
      final response = await _dio.post(
        ApiConstants.reviews,
        data: request.toJson(),
      );
      return ReviewModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<ReviewModel> updateReview(
      int id, UpdateReviewRequest request) async {
    try {
      final response = await _dio.put(
        ApiConstants.reviewById(id),
        data: request.toJson(),
      );
      return ReviewModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<void> deleteReview(int id) async {
    try {
      await _dio.delete(ApiConstants.reviewById(id));
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }
}
