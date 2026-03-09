import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/models/paged_result.dart';
import '../../../core/network/api_exception.dart';
import '../../../core/network/dio_client.dart';
import '../models/order_model.dart';

final ordersRepositoryProvider = Provider<OrdersRepository>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return OrdersRepository(dioClient.dio);
});

class OrdersRepository {
  final Dio _dio;

  OrdersRepository(this._dio);

  Future<PagedResult<OrderModel>> getOrders({
    int pageNumber = 1,
    int pageSize = 10,
    String? search,
    int? status,
    int? userId,
    String? sortBy,
    bool? sortDescending,
    String? excludeStatuses,
  }) async {
    try {
      final response = await _dio.get(
        ApiConstants.orders,
        queryParameters: {
          'pageNumber': pageNumber,
          'pageSize': pageSize,
          if (search != null && search.isNotEmpty) 'search': search,
          if (status != null) 'status': status,
          if (userId != null) 'userId': userId,
          if (sortBy != null) 'sortBy': sortBy,
          if (sortDescending != null) 'sortDescending': sortDescending,
          if (excludeStatuses != null) 'excludeStatuses': excludeStatuses,
        },
      );
      return PagedResult.fromJson(
        response.data,
        (json) => OrderModel.fromJson(json),
      );
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<OrderModel> updateStatus(int id, int status) async {
    try {
      final response = await _dio.put(
        ApiConstants.orderStatus(id),
        data: {'status': status},
      );
      return OrderModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }
}
