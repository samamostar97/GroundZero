import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/models/paged_result.dart';
import '../../../core/network/api_exception.dart';
import '../../../core/network/dio_client.dart';
import '../models/category_model.dart';
import '../models/product_model.dart';
import '../models/recommended_product_model.dart';

final productRepositoryProvider = Provider<ProductRepository>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return ProductRepository(dioClient.dio);
});

class ProductRepository {
  final Dio _dio;

  ProductRepository(this._dio);

  Future<PagedResult<ProductModel>> getProducts({
    int pageNumber = 1,
    int pageSize = 10,
    String? search,
    int? categoryId,
    double? minPrice,
    double? maxPrice,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'pageNumber': pageNumber,
        'pageSize': pageSize,
      };
      if (search != null && search.isNotEmpty) queryParams['search'] = search;
      if (categoryId != null) queryParams['categoryId'] = categoryId;
      if (minPrice != null) queryParams['minPrice'] = minPrice;
      if (maxPrice != null) queryParams['maxPrice'] = maxPrice;

      final response = await _dio.get(
        ApiConstants.products,
        queryParameters: queryParams,
      );
      return PagedResult.fromJson(
        response.data,
        (json) => ProductModel.fromJson(json),
      );
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<ProductModel> getProductById(int id) async {
    try {
      final response = await _dio.get('${ApiConstants.products}/$id');
      return ProductModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<List<CategoryModel>> getCategories() async {
    try {
      final response = await _dio.get(ApiConstants.categories);
      return (response.data as List)
          .map((e) => CategoryModel.fromJson(e))
          .toList();
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<List<RecommendedProductModel>> getUserRecommendations({
    int limit = 10,
  }) async {
    try {
      final response = await _dio.get(
        ApiConstants.userRecommendations,
        queryParameters: {'limit': limit},
      );
      return (response.data as List)
          .map((e) => RecommendedProductModel.fromJson(e))
          .toList();
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }
}
