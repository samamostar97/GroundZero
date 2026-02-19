import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/auth_models.dart';
import '../repositories/auth_repository.dart';

final authStateProvider = StateNotifierProvider<AuthNotifier, AsyncValue<AuthResponse?>>((ref) =>
    AuthNotifier(ref.read(authRepositoryProvider)));

class AuthNotifier extends StateNotifier<AsyncValue<AuthResponse?>> {
  final AuthRepository _repo;
  AuthNotifier(this._repo) : super(const AsyncValue.data(null)) { _checkToken(); }

  Future<void> _checkToken() async {
    final token = await _repo.getSavedToken();
    if (token != null) state = AsyncValue.data(AuthResponse(token: token, email: '', userId: ''));
  }

  Future<void> login(String email, String password) async {
    state = const AsyncValue.loading();
    try { state = AsyncValue.data(await _repo.login(LoginRequest(email: email, password: password))); }
    catch (e, st) { state = AsyncValue.error(e, st); }
  }

  Future<void> register(String email, String password) async {
    state = const AsyncValue.loading();
    try { await _repo.register(RegisterRequest(email: email, password: password)); await login(email, password); }
    catch (e, st) { state = AsyncValue.error(e, st); }
  }

  Future<void> logout() async { await _repo.logout(); state = const AsyncValue.data(null); }
}