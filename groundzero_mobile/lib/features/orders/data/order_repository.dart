import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/models/paged_result.dart';
import '../../../core/network/api_exception.dart';
import '../../../core/network/dio_client.dart';
import '../models/create_order_request.dart';
import '../models/order_model.dart';

final orderRepositoryProvider = Provider<OrderRepository>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return OrderRepository(dioClient.dio);
});

class OrderRepository {
  final Dio _dio;

  OrderRepository(this._dio);

  Future<OrderModel> createOrder(CreateOrderRequest request) async {
    try {
      final response = await _dio.post(
        ApiConstants.orders,
        data: request.toJson(),
      );
      return OrderModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<PagedResult<OrderModel>> getMyOrders({
    int pageNumber = 1,
    int pageSize = 10,
    int? status,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'pageNumber': pageNumber,
        'pageSize': pageSize,
      };
      if (status != null) queryParams['status'] = status;

      final response = await _dio.get(
        ApiConstants.myOrders,
        queryParameters: queryParams,
      );
      return PagedResult.fromJson(
        response.data,
        (json) => OrderModel.fromJson(json),
      );
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<OrderModel> getOrderById(int id) async {
    try {
      final response = await _dio.get('${ApiConstants.orders}/$id');
      return OrderModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }
}
