import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/models/paged_result.dart';
import '../../../core/network/api_exception.dart';
import '../../../core/network/dio_client.dart';
import '../models/add_workout_day_request.dart';
import '../models/add_workout_exercise_request.dart';
import '../models/workout_plan_model.dart';

final workoutRepositoryProvider = Provider<WorkoutRepository>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return WorkoutRepository(dioClient.dio);
});

class WorkoutRepository {
  final Dio _dio;

  WorkoutRepository(this._dio);

  // --- Plans ---

  Future<PagedResult<WorkoutPlanModel>> getMyPlans({
    int pageNumber = 1,
    int pageSize = 10,
    String? search,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'pageNumber': pageNumber,
        'pageSize': pageSize,
      };
      if (search != null && search.isNotEmpty) queryParams['search'] = search;

      final response = await _dio.get(
        ApiConstants.workoutPlans,
        queryParameters: queryParams,
      );
      return PagedResult.fromJson(
        response.data,
        (json) => WorkoutPlanModel.fromJson(json),
      );
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<WorkoutPlanModel> getPlanById(int id) async {
    try {
      final response = await _dio.get('${ApiConstants.workoutPlans}/$id');
      return WorkoutPlanModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<WorkoutPlanModel> createPlan({
    required String name,
    String? description,
  }) async {
    try {
      final response = await _dio.post(
        ApiConstants.workoutPlans,
        data: {'name': name, 'description': description},
      );
      return WorkoutPlanModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<WorkoutPlanModel> updatePlan(
    int id, {
    required String name,
    String? description,
  }) async {
    try {
      final response = await _dio.put(
        '${ApiConstants.workoutPlans}/$id',
        data: {'name': name, 'description': description},
      );
      return WorkoutPlanModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<void> deletePlan(int id) async {
    try {
      await _dio.delete('${ApiConstants.workoutPlans}/$id');
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  // --- Days ---

  Future<void> addDay(
    int planId,
    AddWorkoutDayRequest request,
  ) async {
    try {
      await _dio.post(
        '${ApiConstants.workoutPlans}/$planId/days',
        data: request.toJson(),
      );
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<void> updateDay(
    int planId,
    int dayId,
    AddWorkoutDayRequest request,
  ) async {
    try {
      await _dio.put(
        '${ApiConstants.workoutPlans}/$planId/days/$dayId',
        data: request.toJson(),
      );
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<void> removeDay(int planId, int dayId) async {
    try {
      await _dio.delete('${ApiConstants.workoutPlans}/$planId/days/$dayId');
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  // --- Exercises ---

  Future<void> addExercise(
    int planId,
    int dayId,
    AddWorkoutExerciseRequest request,
  ) async {
    try {
      await _dio.post(
        '${ApiConstants.workoutPlans}/$planId/days/$dayId/exercises',
        data: request.toJson(),
      );
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<void> updateExercise(
    int planId,
    int dayId,
    int exerciseId, {
    required int sets,
    required int reps,
    double? weight,
    int? restSeconds,
    required int orderIndex,
  }) async {
    try {
      await _dio.put(
        '${ApiConstants.workoutPlans}/$planId/days/$dayId/exercises/$exerciseId',
        data: {
          'sets': sets,
          'reps': reps,
          'weight': weight,
          'restSeconds': restSeconds,
          'orderIndex': orderIndex,
        },
      );
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<void> removeExercise(int planId, int dayId, int exerciseId) async {
    try {
      await _dio.delete(
        '${ApiConstants.workoutPlans}/$planId/days/$dayId/exercises/$exerciseId',
      );
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }
}
