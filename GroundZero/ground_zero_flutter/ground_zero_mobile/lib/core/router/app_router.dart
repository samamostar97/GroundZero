import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ground_zero_core/ground_zero_core.dart';
import '../../features/auth/screens/login_screen.dart';
import '../../features/products/screens/products_screen.dart';
import '../../features/profile/screens/profile_screen.dart';

final _rootNavKey = GlobalKey<NavigatorState>();
final _shellNavKey = GlobalKey<NavigatorState>();

final routerProvider = Provider<GoRouter>((ref) {
  final auth = ref.watch(authStateProvider);
  return GoRouter(
    navigatorKey: _rootNavKey,
    initialLocation: '/products',
    redirect: (_, state) {
      final loggedIn = auth.value != null;
      if (!loggedIn && state.matchedLocation != '/login') return '/login';
      if (loggedIn && state.matchedLocation == '/login') return '/products';
      return null;
    },
    routes: [
      GoRoute(path: '/login', builder: (_, __) => const MobileLoginScreen()),
      StatefulShellRoute.indexedStack(
        builder: (_, __, shell) => Scaffold(
          body: shell,
          bottomNavigationBar: NavigationBar(
            selectedIndex: shell.currentIndex,
            onDestinationSelected: shell.goBranch,
            destinations: const [
              NavigationDestination(icon: Icon(Icons.storefront_outlined), selectedIcon: Icon(Icons.storefront), label: 'Products'),
              NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'Profile'),
            ],
          ),
        ),
        branches: [
          StatefulShellBranch(navigatorKey: _shellNavKey, routes: [
            GoRoute(path: '/products', builder: (_, __) => const MobileProductsScreen()),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(path: '/profile', builder: (_, __) => const ProfileScreen()),
          ]),
        ],
      ),
    ],
  );
});