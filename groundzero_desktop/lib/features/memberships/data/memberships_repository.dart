import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/models/paged_result.dart';
import '../../../core/network/api_exception.dart';
import '../../../core/network/dio_client.dart';
import '../models/membership_model.dart';

final membershipsRepositoryProvider = Provider<MembershipsRepository>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return MembershipsRepository(dioClient.dio);
});

class MembershipsRepository {
  final Dio _dio;

  MembershipsRepository(this._dio);

  Future<PagedResult<MembershipModel>> getMemberships({
    int pageNumber = 1,
    int pageSize = 10,
    String? search,
    String? status,
  }) async {
    try {
      final response = await _dio.get(
        ApiConstants.memberships,
        queryParameters: {
          'pageNumber': pageNumber,
          'pageSize': pageSize,
          if (search != null && search.isNotEmpty) 'search': search,
          if (status != null) 'status': status,
        },
      );
      return PagedResult.fromJson(
        response.data,
        (json) => MembershipModel.fromJson(json),
      );
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<MembershipModel> assign(Map<String, dynamic> data) async {
    try {
      final response = await _dio.post(
        ApiConstants.memberships,
        data: data,
      );
      return MembershipModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<MembershipModel> cancel(int id) async {
    try {
      final response = await _dio.put(ApiConstants.cancelMembership(id));
      return MembershipModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }
}
