import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/models/paged_result.dart';
import '../../../core/network/api_exception.dart';
import '../../../core/network/dio_client.dart';
import '../models/user_model.dart';

final usersRepositoryProvider = Provider<UsersRepository>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return UsersRepository(dioClient.dio);
});

class UsersRepository {
  final Dio _dio;

  UsersRepository(this._dio);

  Future<PagedResult<UserModel>> getUsers({
    int pageNumber = 1,
    int pageSize = 10,
    String? search,
  }) async {
    try {
      final response = await _dio.get(
        ApiConstants.users,
        queryParameters: {
          'pageNumber': pageNumber,
          'pageSize': pageSize,
          if (search != null && search.isNotEmpty) 'search': search,
        },
      );
      return PagedResult.fromJson(
        response.data,
        (json) => UserModel.fromJson(json),
      );
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<UserModel> getUserById(int id) async {
    try {
      final response = await _dio.get('${ApiConstants.users}/$id');
      return UserModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<void> deleteUser(int id) async {
    try {
      await _dio.delete('${ApiConstants.users}/$id');
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }
}
