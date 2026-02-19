import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../network/api_constants.dart';
import '../network/api_client.dart';
import '../models/paged_result.dart';
import '../models/product_model.dart';

final productRepositoryProvider = Provider<ProductRepository>((ref) =>
    ProductRepository(ref.read(dioProvider)));

class ProductRepository {
  final Dio _dio;
  ProductRepository(this._dio);

  Future<PagedResult<ProductModel>> getProducts({int page = 1, int pageSize = 10,
      String? searchTerm, String? sortBy, bool sortDescending = false}) async {
    final resp = await _dio.get(ApiConstants.products, queryParameters: {
      'page': page, 'pageSize': pageSize,
      if (searchTerm != null) 'searchTerm': searchTerm,
      if (sortBy != null) 'sortBy': sortBy, 'sortDescending': sortDescending });
    return PagedResult.fromJson(resp.data, ProductModel.fromJson);
  }

  Future<ProductModel> getById(String id) async =>
      ProductModel.fromJson((await _dio.get(ApiConstants.productById(id))).data);

  Future<ProductModel> create(Map<String, dynamic> data) async =>
      ProductModel.fromJson((await _dio.post(ApiConstants.products, data: data)).data);

  Future<ProductModel> update(String id, Map<String, dynamic> data) async =>
      ProductModel.fromJson((await _dio.put(ApiConstants.productById(id), data: data)).data);

  Future<void> delete(String id) async => await _dio.delete(ApiConstants.productById(id));
}