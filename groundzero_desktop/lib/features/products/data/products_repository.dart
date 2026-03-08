import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/models/paged_result.dart';
import '../../../core/network/api_exception.dart';
import '../../../core/network/dio_client.dart';
import '../models/product_model.dart';

final productsRepositoryProvider = Provider<ProductsRepository>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return ProductsRepository(dioClient.dio);
});

class ProductsRepository {
  final Dio _dio;

  ProductsRepository(this._dio);

  Future<PagedResult<ProductModel>> getProducts({
    int pageNumber = 1,
    int pageSize = 10,
    String? search,
    int? categoryId,
    double? minPrice,
    double? maxPrice,
    String? sortBy,
    bool? sortDescending,
  }) async {
    try {
      final response = await _dio.get(
        ApiConstants.products,
        queryParameters: {
          'pageNumber': pageNumber,
          'pageSize': pageSize,
          if (search != null && search.isNotEmpty) 'search': search,
          if (categoryId != null) 'categoryId': categoryId,
          if (minPrice != null) 'minPrice': minPrice,
          if (maxPrice != null) 'maxPrice': maxPrice,
          if (sortBy != null) 'sortBy': sortBy,
          if (sortDescending != null) 'sortDescending': sortDescending,
        },
      );
      return PagedResult.fromJson(
        response.data,
        (json) => ProductModel.fromJson(json),
      );
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<ProductModel> create(Map<String, dynamic> data) async {
    try {
      final response = await _dio.post(ApiConstants.products, data: data);
      return ProductModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<ProductModel> update(int id, Map<String, dynamic> data) async {
    try {
      final response =
          await _dio.put('${ApiConstants.products}/$id', data: data);
      return ProductModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<void> uploadImage(int id, String filePath) async {
    try {
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(filePath),
      });
      await _dio.post(
        ApiConstants.productImage(id),
        data: formData,
        options: Options(contentType: 'multipart/form-data'),
      );
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<void> delete(int id) async {
    try {
      await _dio.delete('${ApiConstants.products}/$id');
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }
}
