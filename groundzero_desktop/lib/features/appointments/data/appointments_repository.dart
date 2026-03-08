import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/models/paged_result.dart';
import '../../../core/network/api_exception.dart';
import '../../../core/network/dio_client.dart';
import '../models/appointment_model.dart';

final appointmentsRepositoryProvider = Provider<AppointmentsRepository>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return AppointmentsRepository(dioClient.dio);
});

class AppointmentsRepository {
  final Dio _dio;

  AppointmentsRepository(this._dio);

  Future<PagedResult<AppointmentModel>> getAppointments({
    int pageNumber = 1,
    int pageSize = 10,
    String? search,
    int? status,
    int? staffId,
    String? sortBy,
    bool? sortDescending,
  }) async {
    try {
      final response = await _dio.get(
        ApiConstants.appointments,
        queryParameters: {
          'pageNumber': pageNumber,
          'pageSize': pageSize,
          if (search != null && search.isNotEmpty) 'search': search,
          if (status != null) 'status': status,
          if (staffId != null) 'staffId': staffId,
          if (sortBy != null) 'sortBy': sortBy,
          if (sortDescending != null) 'sortDescending': sortDescending,
        },
      );
      return PagedResult.fromJson(
        response.data,
        (json) => AppointmentModel.fromJson(json),
      );
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<AppointmentModel> updateStatus(int id, int status) async {
    try {
      final response = await _dio.put(
        ApiConstants.appointmentStatus(id),
        data: {'status': status},
      );
      return AppointmentModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<AppointmentModel> cancel(int id) async {
    try {
      final response = await _dio.put(ApiConstants.appointmentCancel(id));
      return AppointmentModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }
}
