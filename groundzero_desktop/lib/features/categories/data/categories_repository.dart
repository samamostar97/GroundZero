import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/network/api_exception.dart';
import '../../../core/network/dio_client.dart';
import '../models/category_model.dart';

final categoriesRepositoryProvider = Provider<CategoriesRepository>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return CategoriesRepository(dioClient.dio);
});

class CategoriesRepository {
  final Dio _dio;

  CategoriesRepository(this._dio);

  Future<List<CategoryModel>> getAll() async {
    try {
      final response = await _dio.get(ApiConstants.categories);
      return (response.data as List)
          .map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<CategoryModel> create(Map<String, dynamic> data) async {
    try {
      final response = await _dio.post(ApiConstants.categories, data: data);
      return CategoryModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<CategoryModel> update(int id, Map<String, dynamic> data) async {
    try {
      final response =
          await _dio.put('${ApiConstants.categories}/$id', data: data);
      return CategoryModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<void> delete(int id) async {
    try {
      await _dio.delete('${ApiConstants.categories}/$id');
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }
}
