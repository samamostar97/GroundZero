import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/network/api_exception.dart';
import '../../../core/network/dio_client.dart';
import '../models/membership_plan_model.dart';

final membershipPlansRepositoryProvider =
    Provider<MembershipPlansRepository>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return MembershipPlansRepository(dioClient.dio);
});

class MembershipPlansRepository {
  final Dio _dio;

  MembershipPlansRepository(this._dio);

  Future<List<MembershipPlanModel>> getAll({bool? isActive}) async {
    try {
      final response = await _dio.get(
        ApiConstants.membershipPlans,
        queryParameters: {
          if (isActive != null) 'isActive': isActive,
        },
      );
      return (response.data as List)
          .map((e) =>
              MembershipPlanModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<MembershipPlanModel> create(Map<String, dynamic> data) async {
    try {
      final response =
          await _dio.post(ApiConstants.membershipPlans, data: data);
      return MembershipPlanModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<MembershipPlanModel> update(
      int id, Map<String, dynamic> data) async {
    try {
      final response =
          await _dio.put('${ApiConstants.membershipPlans}/$id', data: data);
      return MembershipPlanModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<void> delete(int id) async {
    try {
      await _dio.delete('${ApiConstants.membershipPlans}/$id');
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }
}
