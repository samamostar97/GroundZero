import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/models/paged_result.dart';
import '../../../core/network/api_exception.dart';
import '../../../core/network/dio_client.dart';
import '../models/appointment_model.dart';
import '../models/create_appointment_request.dart';

final appointmentRepositoryProvider = Provider<AppointmentRepository>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return AppointmentRepository(dioClient.dio);
});

class AppointmentRepository {
  final Dio _dio;

  AppointmentRepository(this._dio);

  Future<AppointmentModel> createAppointment(
    CreateAppointmentRequest request,
  ) async {
    try {
      final response = await _dio.post(
        ApiConstants.appointments,
        data: request.toJson(),
      );
      return AppointmentModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<PagedResult<AppointmentModel>> getMyAppointments({
    int pageNumber = 1,
    int pageSize = 10,
    String? status,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'pageNumber': pageNumber,
        'pageSize': pageSize,
      };
      if (status != null) queryParams['status'] = status;

      final response = await _dio.get(
        ApiConstants.myAppointments,
        queryParameters: queryParams,
      );
      return PagedResult.fromJson(
        response.data,
        (json) => AppointmentModel.fromJson(json),
      );
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<AppointmentModel> getAppointmentById(int id) async {
    try {
      final response = await _dio.get('${ApiConstants.appointments}/$id');
      return AppointmentModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<AppointmentModel> cancelAppointment(int id) async {
    try {
      final response = await _dio.put(
        '${ApiConstants.appointments}/$id/cancel',
      );
      return AppointmentModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }
}
