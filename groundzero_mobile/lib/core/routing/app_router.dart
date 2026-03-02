import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/providers/auth_provider.dart';
import '../../features/auth/screens/login_screen.dart';
import '../../features/auth/screens/register_screen.dart';
import '../../home/screens/home_screen.dart';

abstract class AppRoutes {
  static const String splash = '/splash';
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/';
}

final appRouterProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authNotifierProvider);

  return GoRouter(
    initialLocation: AppRoutes.splash,
    debugLogDiagnostics: true,
    redirect: (context, state) {
      final isAuth = authState is AuthAuthenticated;
      final isLoading =
          authState is AuthInitial || authState is AuthLoading;
      final location = state.matchedLocation;

      final isOnAuthPage =
          location == AppRoutes.login || location == AppRoutes.register;
      final isOnSplash = location == AppRoutes.splash;

      // While checking tokens, stay on splash
      if (isLoading) {
        return isOnSplash ? null : AppRoutes.splash;
      }

      // Not authenticated → go to login
      if (!isAuth) {
        return isOnAuthPage ? null : AppRoutes.login;
      }

      // Authenticated but on auth/splash page → go home
      if (isAuth && (isOnAuthPage || isOnSplash)) {
        return AppRoutes.home;
      }

      return null;
    },
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => const _SplashScreen(),
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.register,
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) => const HomeScreen(),
      ),
    ],
  );
});

class _SplashScreen extends StatelessWidget {
  const _SplashScreen();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
