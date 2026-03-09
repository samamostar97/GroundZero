import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/network/api_exception.dart';
import '../../../core/network/dio_client.dart';
import '../models/activity_feed_item.dart';
import '../models/dashboard_model.dart';

final dashboardRepositoryProvider = Provider<DashboardRepository>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return DashboardRepository(dioClient.dio);
});

class DashboardRepository {
  final Dio _dio;

  DashboardRepository(this._dio);

  Future<DashboardModel> getDashboard() async {
    try {
      final response = await _dio.get(ApiConstants.dashboard);
      return DashboardModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<List<ActivityFeedItem>> getActivityFeed({int count = 20}) async {
    try {
      final response = await _dio.get(
        ApiConstants.activityFeed,
        queryParameters: {'count': count},
      );
      return (response.data as List)
          .map((e) => ActivityFeedItem.fromJson(e))
          .toList();
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }
}
