import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/models/paged_result.dart';
import '../../../core/network/api_exception.dart';
import '../../../core/network/dio_client.dart';
import '../../auth/models/user_model.dart';
import '../models/gamification_model.dart';
import '../models/leaderboard_entry_model.dart';
import '../models/update_profile_request.dart';

final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return ProfileRepository(dioClient.dio);
});

class ProfileRepository {
  final Dio _dio;

  ProfileRepository(this._dio);

  Future<UserModel> updateProfile(UpdateProfileRequest request) async {
    try {
      final response = await _dio.put(
        ApiConstants.updateProfile,
        data: request.toJson(),
      );
      return UserModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<UserModel> uploadProfilePicture(XFile image) async {
    try {
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(
          image.path,
          filename: image.name,
        ),
      });
      final response = await _dio.post(
        ApiConstants.uploadProfilePicture,
        data: formData,
        options: Options(
          contentType: 'multipart/form-data',
        ),
      );
      return UserModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<void> changePassword(String currentPassword, String newPassword) async {
    try {
      await _dio.patch(
        ApiConstants.changePassword,
        data: {
          'currentPassword': currentPassword,
          'newPassword': newPassword,
        },
      );
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<GamificationModel> getMyGamification() async {
    try {
      final response = await _dio.get(ApiConstants.myGamification);
      return GamificationModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<PagedResult<LeaderboardEntryModel>> getLeaderboard({
    int pageNumber = 1,
    int pageSize = 20,
  }) async {
    try {
      final response = await _dio.get(
        ApiConstants.leaderboard,
        queryParameters: {
          'pageNumber': pageNumber,
          'pageSize': pageSize,
        },
      );
      return PagedResult.fromJson(
        response.data,
        (json) => LeaderboardEntryModel.fromJson(json),
      );
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }
}
