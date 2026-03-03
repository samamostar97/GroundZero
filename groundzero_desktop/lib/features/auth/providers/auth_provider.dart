import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_exception.dart';
import '../../../core/network/dio_client.dart';
import '../../../core/storage/token_storage.dart';
import '../data/auth_repository.dart';
import '../models/login_request.dart';

// Auth state
sealed class AuthState {
  const AuthState();
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class AuthLoading extends AuthState {
  const AuthLoading();
}

class AuthAuthenticated extends AuthState {
  const AuthAuthenticated();
}

class AuthUnauthenticated extends AuthState {
  final String? error;
  const AuthUnauthenticated({this.error});
}

// Provider
final authNotifierProvider =
    NotifierProvider<AuthNotifier, AuthState>(AuthNotifier.new);

class AuthNotifier extends Notifier<AuthState> {
  late final AuthRepository _authRepository;
  late final TokenStorage _storage;
  late final DioClient _dioClient;

  @override
  AuthState build() {
    _authRepository = ref.watch(authRepositoryProvider);
    _storage = ref.watch(tokenStorageProvider);
    _dioClient = ref.watch(dioClientProvider);

    _dioClient.setOnTokenExpired(() {
      _setUnauthenticated();
    });

    _checkStoredTokens();

    return const AuthInitial();
  }

  Future<void> _checkStoredTokens() async {
    final token = await _storage.getAccessToken();
    if (token != null) {
      state = const AuthAuthenticated();
    } else {
      state = const AuthUnauthenticated();
    }
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    state = const AuthLoading();

    try {
      final response = await _authRepository.login(
        LoginRequest(email: email, password: password),
      );

      await _storage.saveTokens(
        accessToken: response.accessToken,
        refreshToken: response.refreshToken,
      );

      state = const AuthAuthenticated();
    } on ApiException catch (e) {
      state = AuthUnauthenticated(error: e.firstError);
    } catch (_) {
      state = const AuthUnauthenticated(
        error: 'Neočekivana greška. Pokušajte ponovo.',
      );
    }
  }

  Future<void> logout() async {
    try {
      await _authRepository.logout();
    } catch (_) {
      // Still clear local tokens even if server call fails
    }
    await _storage.clearTokens();
    state = const AuthUnauthenticated();
  }

  void _setUnauthenticated() {
    _storage.clearTokens();
    state = const AuthUnauthenticated(
      error: 'Sesija je istekla. Prijavite se ponovo.',
    );
  }
}
