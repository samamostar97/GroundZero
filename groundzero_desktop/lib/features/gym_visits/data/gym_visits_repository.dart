import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/models/paged_result.dart';
import '../../../core/network/api_exception.dart';
import '../../../core/network/dio_client.dart';
import '../models/gym_visit_model.dart';

final gymVisitsRepositoryProvider = Provider<GymVisitsRepository>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return GymVisitsRepository(dioClient.dio);
});

class GymVisitsRepository {
  final Dio _dio;

  GymVisitsRepository(this._dio);

  Future<PagedResult<GymVisitModel>> getVisits({
    int pageNumber = 1,
    int pageSize = 10,
    String? search,
    String? sortBy,
    bool? sortDescending,
  }) async {
    try {
      final response = await _dio.get(
        ApiConstants.gymVisits,
        queryParameters: {
          'pageNumber': pageNumber,
          'pageSize': pageSize,
          if (search != null && search.isNotEmpty) 'search': search,
          if (sortBy != null) 'sortBy': sortBy,
          if (sortDescending != null) 'sortDescending': sortDescending,
        },
      );
      return PagedResult.fromJson(
        response.data,
        (json) => GymVisitModel.fromJson(json),
      );
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<GymVisitModel> checkIn(int userId) async {
    try {
      final response = await _dio.post(
        ApiConstants.checkIn,
        data: {'userId': userId},
      );
      return GymVisitModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<GymVisitModel> checkOut(int userId) async {
    try {
      final response = await _dio.post(
        ApiConstants.checkOut,
        data: {'userId': userId},
      );
      return GymVisitModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }
}
