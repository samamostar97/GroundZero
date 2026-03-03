import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/models/paged_result.dart';
import '../../../core/network/api_exception.dart';
import '../../../core/network/dio_client.dart';
import '../models/staff_model.dart';

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
      final response = await _dio.get(
        ApiConstants.staff,
        queryParameters: {
          'pageNumber': pageNumber,
          'pageSize': pageSize,
          if (search != null && search.isNotEmpty) 'search': search,
          if (staffType != null && staffType.isNotEmpty) 'staffType': staffType,
        },
      );
      return PagedResult.fromJson(
        response.data,
        (json) => StaffModel.fromJson(json),
      );
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<StaffModel> createStaff(Map<String, dynamic> data) async {
    try {
      final response = await _dio.post(ApiConstants.staff, data: data);
      return StaffModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<StaffModel> updateStaff(int id, Map<String, dynamic> data) async {
    try {
      final response =
          await _dio.put('${ApiConstants.staff}/$id', data: data);
      return StaffModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<void> uploadPicture(int id, String filePath) async {
    try {
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(filePath),
      });
      await _dio.post(
        ApiConstants.staffPicture(id),
        data: formData,
        options: Options(contentType: 'multipart/form-data'),
      );
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<void> deleteStaff(int id) async {
    try {
      await _dio.delete('${ApiConstants.staff}/$id');
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }
}
