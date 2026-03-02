import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/auth_repository.dart';
import '../models/user_model.dart';
import 'auth_provider.dart';

final userNotifierProvider =
    NotifierProvider<UserNotifier, AsyncValue<UserModel?>>(UserNotifier.new);

class UserNotifier extends Notifier<AsyncValue<UserModel?>> {
  @override
  AsyncValue<UserModel?> build() {
    // Watch auth state — refetch when auth changes
    final authState = ref.watch(authNotifierProvider);

    if (authState is AuthAuthenticated) {
      _fetchUser();
    } else {
      return const AsyncData(null);
    }

    return const AsyncLoading();
  }

  Future<void> _fetchUser() async {
    try {
      final repo = ref.read(authRepositoryProvider);
      final user = await repo.getCurrentUser();
      state = AsyncData(user);
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
    }
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    await _fetchUser();
  }
}
