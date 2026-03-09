import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/models/paged_result.dart';
import '../../../core/network/api_exception.dart';
import '../../../core/network/dio_client.dart';
import '../models/membership_plan_model.dart';
import '../models/user_membership_model.dart';

final membershipRepositoryProvider = Provider<MembershipRepository>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return MembershipRepository(dioClient.dio);
});

class MembershipRepository {
  final Dio _dio;

  MembershipRepository(this._dio);

  Future<UserMembershipModel?> getMyMembership() async {
    try {
      final response = await _dio.get(ApiConstants.myMembership);
      if (response.data == null || response.data is! Map<String, dynamic>) {
        return null;
      }
      return UserMembershipModel.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<PagedResult<UserMembershipModel>> getMyMembershipHistory({
    int pageNumber = 1,
    int pageSize = 10,
  }) async {
    try {
      final response = await _dio.get(
        ApiConstants.myMembershipHistory,
        queryParameters: {
          'pageNumber': pageNumber,
          'pageSize': pageSize,
        },
      );
      return PagedResult.fromJson(
        response.data as Map<String, dynamic>,
        (json) => UserMembershipModel.fromJson(json),
      );
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<List<MembershipPlanModel>> getMembershipPlans({bool? isActive}) async {
    try {
      final queryParams = <String, dynamic>{};
      if (isActive != null) queryParams['isActive'] = isActive;

      final response = await _dio.get(
        ApiConstants.membershipPlans,
        queryParameters: queryParams,
      );
      return (response.data as List)
          .map((e) => MembershipPlanModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }
}
