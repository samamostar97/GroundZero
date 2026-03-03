import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/network/api_exception.dart';
import '../../../core/network/dio_client.dart';
import '../models/exercise_model.dart';

final exerciseRepositoryProvider = Provider<ExerciseRepository>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return ExerciseRepository(dioClient.dio);
});

class ExerciseRepository {
  final Dio _dio;

  ExerciseRepository(this._dio);

  Future<List<ExerciseModel>> getExercises({int? muscleGroup}) async {
    try {
      final queryParams = <String, dynamic>{};
      if (muscleGroup != null) queryParams['muscleGroup'] = muscleGroup;

      final response = await _dio.get(
        ApiConstants.exercises,
        queryParameters: queryParams,
      );
      return (response.data as List)
          .map((e) => ExerciseModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }
}
