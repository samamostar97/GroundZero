import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/api_constants.dart';
import '../storage/secure_storage_service.dart';
import 'auth_interceptor.dart';

final dioClientProvider = Provider<DioClient>((ref) {
  final storage = ref.watch(secureStorageServiceProvider);
  return DioClient(storage: storage);
});

class DioClient {
  late final Dio dio;
  final SecureStorageService _storage;
  void Function()? _onTokenExpired;

  DioClient({required SecureStorageService storage}) : _storage = storage {
    dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        sendTimeout: const Duration(seconds: 15),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    dio.interceptors.add(
      AuthInterceptor(
        dio: dio,
        storage: _storage,
        onTokenExpired: () => _onTokenExpired?.call(),
      ),
    );
  }

  void setOnTokenExpired(void Function() callback) {
    _onTokenExpired = callback;
  }
}
