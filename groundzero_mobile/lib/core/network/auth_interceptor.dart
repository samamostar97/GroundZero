import 'dart:async';

import 'package:dio/dio.dart';

import '../constants/api_constants.dart';
import '../storage/secure_storage_service.dart';

class AuthInterceptor extends Interceptor {
  final Dio _dio;
  final SecureStorageService _storage;
  final void Function() _onTokenExpired;

  bool _isRefreshing = false;
  Completer<String?>? _refreshCompleter;

  AuthInterceptor({
    required Dio dio,
    required SecureStorageService storage,
    required void Function() onTokenExpired,
  })  : _dio = dio,
        _storage = storage,
        _onTokenExpired = onTokenExpired;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _storage.getAccessToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode != 401) {
      return handler.next(err);
    }

    // Don't try to refresh if the failing request was itself a refresh
    final path = err.requestOptions.path;
    if (path.contains('/auth/refresh') || path.contains('/auth/login')) {
      return handler.next(err);
    }

    try {
      final newToken = await _refreshToken();
      if (newToken == null) {
        _onTokenExpired();
        return handler.next(err);
      }

      // Retry the original request with the new token
      final options = err.requestOptions;
      options.headers['Authorization'] = 'Bearer $newToken';

      final response = await _dio.fetch(options);
      return handler.resolve(response);
    } catch (_) {
      _onTokenExpired();
      return handler.next(err);
    }
  }

  Future<String?> _refreshToken() async {
    // If already refreshing, wait for the ongoing refresh
    if (_isRefreshing) {
      return _refreshCompleter?.future;
    }

    _isRefreshing = true;
    _refreshCompleter = Completer<String?>();

    try {
      final refreshToken = await _storage.getRefreshToken();
      if (refreshToken == null) {
        _refreshCompleter!.complete(null);
        return null;
      }

      // Use a separate Dio instance to avoid interceptor loop
      final refreshDio = Dio(BaseOptions(baseUrl: ApiConstants.baseUrl));

      final response = await refreshDio.post(
        ApiConstants.refreshToken,
        data: {'refreshToken': refreshToken},
      );

      final newAccessToken = response.data['accessToken'] as String;
      final newRefreshToken = response.data['refreshToken'] as String;

      await _storage.saveTokens(
        accessToken: newAccessToken,
        refreshToken: newRefreshToken,
      );

      _refreshCompleter!.complete(newAccessToken);
      return newAccessToken;
    } catch (_) {
      await _storage.clearTokens();
      _refreshCompleter!.complete(null);
      return null;
    } finally {
      _isRefreshing = false;
      _refreshCompleter = null;
    }
  }
}
