import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/providers/auth_provider.dart';
import '../../features/auth/screens/login_screen.dart';
import '../../shared/widgets/app_shell.dart';

abstract class AppRoutes {
  static const String login = '/login';
  static const String home = '/';
}

final appRouterProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authNotifierProvider);

  return GoRouter(
    initialLocation: AppRoutes.login,
    redirect: (context, state) {
      final isLogin = state.matchedLocation == AppRoutes.login;

      if (authState is AuthInitial) {
        return AppRoutes.login;
      }

      if (authState is AuthUnauthenticated || authState is AuthLoading) {
        return isLogin ? null : AppRoutes.login;
      }

      if (authState is AuthAuthenticated) {
        return isLogin ? AppRoutes.home : null;
      }

      return null;
    },
    routes: [
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) => const AppShell(),
      ),
    ],
  );
});
