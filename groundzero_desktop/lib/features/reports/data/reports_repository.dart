import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/network/api_exception.dart';
import '../../../core/network/dio_client.dart';
import '../models/appointment_report_model.dart';
import '../models/gamification_report_model.dart';
import '../models/product_report_model.dart';
import '../models/revenue_report_model.dart';
import '../models/user_report_model.dart';

final reportsRepositoryProvider = Provider<ReportsRepository>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return ReportsRepository(dioClient.dio);
});

class ReportsRepository {
  final Dio _dio;

  ReportsRepository(this._dio);

  Future<RevenueReportModel> getRevenueData({
    DateTime? from,
    DateTime? to,
  }) async {
    try {
      final response = await _dio.get(
        ApiConstants.revenueReportData,
        queryParameters: {
          if (from != null) 'from': from.toIso8601String(),
          if (to != null) 'to': to.toIso8601String(),
        },
      );
      return RevenueReportModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<ProductReportModel> getProductData({
    DateTime? from,
    DateTime? to,
    int lowStockThreshold = 10,
  }) async {
    try {
      final response = await _dio.get(
        ApiConstants.productReportData,
        queryParameters: {
          if (from != null) 'from': from.toIso8601String(),
          if (to != null) 'to': to.toIso8601String(),
          'lowStockThreshold': lowStockThreshold,
        },
      );
      return ProductReportModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<UserReportModel> getUserData({
    DateTime? from,
    DateTime? to,
  }) async {
    try {
      final response = await _dio.get(
        ApiConstants.userReportData,
        queryParameters: {
          if (from != null) 'from': from.toIso8601String(),
          if (to != null) 'to': to.toIso8601String(),
        },
      );
      return UserReportModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<AppointmentReportModel> getAppointmentData({
    DateTime? from,
    DateTime? to,
  }) async {
    try {
      final response = await _dio.get(
        ApiConstants.appointmentReportData,
        queryParameters: {
          if (from != null) 'from': from.toIso8601String(),
          if (to != null) 'to': to.toIso8601String(),
        },
      );
      return AppointmentReportModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<GamificationReportModel> getGamificationData({
    DateTime? from,
    DateTime? to,
  }) async {
    try {
      final response = await _dio.get(
        ApiConstants.gamificationReportData,
        queryParameters: {
          if (from != null) 'from': from.toIso8601String(),
          if (to != null) 'to': to.toIso8601String(),
        },
      );
      return GamificationReportModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<Uint8List> downloadReport({
    required String endpoint,
    DateTime? from,
    DateTime? to,
    String format = 'Pdf',
    int? lowStockThreshold,
  }) async {
    try {
      final response = await _dio.get(
        endpoint,
        queryParameters: {
          if (from != null) 'from': from.toIso8601String(),
          if (to != null) 'to': to.toIso8601String(),
          'format': format,
          if (lowStockThreshold != null)
            'lowStockThreshold': lowStockThreshold,
        },
        options: Options(responseType: ResponseType.bytes),
      );
      return Uint8List.fromList(response.data);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }
}
