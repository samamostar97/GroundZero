import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/models/paged_result.dart';
import '../../../core/network/api_exception.dart';
import '../../../core/network/dio_client.dart';
import '../models/staff_model.dart';
import '../models/time_slot_model.dart';

final staffRepositoryProvider = Provider<StaffRepository>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return StaffRepository(dioClient.dio);
});

class StaffRepository {
  final Dio _dio;

  StaffRepository(this._dio);

  Future<PagedResult<StaffModel>> getStaff({
    int pageNumber = 1,
    int pageSize = 10,
    String? search,
    String? staffType,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'pageNumber': pageNumber,
        'pageSize': pageSize,
      };
      if (search != null && search.isNotEmpty) queryParams['search'] = search;
      if (staffType != null) queryParams['staffType'] = staffType;

      final response = await _dio.get(
        ApiConstants.staff,
        queryParameters: queryParams,
      );
      return PagedResult.fromJson(
        response.data,
        (json) => StaffModel.fromJson(json),
      );
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<StaffModel> getStaffById(int id) async {
    try {
      final response = await _dio.get('${ApiConstants.staff}/$id');
      return StaffModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<List<TimeSlotModel>> getAvailableSlots(
    int staffId,
    DateTime date,
  ) async {
    try {
      final response = await _dio.get(
        ApiConstants.staffAvailableSlots(staffId),
        queryParameters: {
          'date': date.toIso8601String().split('T').first,
        },
      );
      return (response.data as List)
          .map((e) => TimeSlotModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }
}
