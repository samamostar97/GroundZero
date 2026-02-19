import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../network/api_constants.dart';
import '../network/api_client.dart';
import '../storage/secure_storage.dart';
import '../models/auth_models.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) =>
    AuthRepository(ref.read(dioProvider), ref.read(secureStorageProvider)));

class AuthRepository {
  final Dio _dio; final dynamic _storage;
  AuthRepository(this._dio, this._storage);

  Future<AuthResponse> login(LoginRequest req) async {
    final resp = await _dio.post(ApiConstants.login, data: req.toJson());
    final auth = AuthResponse.fromJson(resp.data);
    await _storage.write(key: 'access_token', value: auth.token);
    await _storage.write(key: 'user_email', value: auth.email);
    await _storage.write(key: 'user_id', value: auth.userId);
    return auth;
  }

  Future<void> register(RegisterRequest req) async =>
      await _dio.post(ApiConstants.register, data: req.toJson());

  Future<void> logout() async => await _storage.deleteAll();
  Future<String?> getSavedToken() async => await _storage.read(key: 'access_token');
}