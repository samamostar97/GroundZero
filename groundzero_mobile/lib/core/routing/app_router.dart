import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/appointments/screens/appointment_detail_screen.dart';
import '../../features/appointments/screens/book_appointment_screen.dart';
import '../../features/appointments/screens/my_appointments_screen.dart';
import '../../features/appointments/screens/staff_detail_screen.dart';
import '../../features/appointments/screens/staff_list_screen.dart';
import '../../features/auth/providers/auth_provider.dart';
import '../../features/auth/screens/login_screen.dart';
import '../../features/auth/screens/register_screen.dart';
import '../../features/home/screens/home_screen.dart';
import '../../features/orders/screens/cart_screen.dart';
import '../../features/orders/screens/my_orders_screen.dart';
import '../../features/orders/screens/order_confirmation_screen.dart';
import '../../features/orders/screens/order_detail_screen.dart';
import '../../features/profile/screens/edit_profile_screen.dart';
import '../../features/profile/screens/leaderboard_screen.dart';
import '../../features/profile/screens/profile_screen.dart';
import '../../features/shell/screens/main_shell_screen.dart';
import '../../features/shop/screens/product_detail_screen.dart';
import '../../features/shop/screens/shop_screen.dart';
import '../../features/membership/screens/membership_screen.dart';
import '../../features/workouts/screens/workout_plan_detail_screen.dart';
import '../../features/workouts/screens/workout_plans_screen.dart';

abstract class AppRoutes {
  static const String splash = '/splash';
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
  static const String shop = '/shop';
  static const String profile = '/profile';
  static const String productDetail = '/shop/:id';
  static const String editProfile = '/profile/edit';
  static const String leaderboard = '/leaderboard';
  static const String cart = '/cart';
  static const String orderConfirmation = '/order-confirmation/:id';
  static const String myOrders = '/orders';
  static const String orderDetail = '/orders/:id';
  static const String staffList = '/staff';
  static const String staffDetail = '/staff/:id';
  static const String bookAppointment = '/book-appointment/:staffId';
  static const String myAppointments = '/appointments';
  static const String appointmentDetail = '/appointments/:id';
  static const String workouts = '/workouts';
  static const String workoutPlanDetail = '/workouts/:id';
  static const String membership = '/membership';
}

final _rootNavigatorKey = GlobalKey<NavigatorState>();

CustomTransitionPage<void> _slideTransition({
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage(
    key: state.pageKey,
    child: child,
    transitionDuration: const Duration(milliseconds: 300),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final curved = CurvedAnimation(parent: animation, curve: Curves.easeOutCubic);
      return SlideTransition(
        position: Tween(
          begin: const Offset(1, 0),
          end: Offset.zero,
        ).animate(curved),
        child: FadeTransition(
          opacity: Tween(begin: 0.5, end: 1.0).animate(curved),
          child: child,
        ),
      );
    },
  );
}

CustomTransitionPage<void> _slideUpTransition({
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage(
    key: state.pageKey,
    child: child,
    transitionDuration: const Duration(milliseconds: 350),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final curved = CurvedAnimation(parent: animation, curve: Curves.easeOutCubic);
      return SlideTransition(
        position: Tween(
          begin: const Offset(0, 0.15),
          end: Offset.zero,
        ).animate(curved),
        child: FadeTransition(
          opacity: Tween(begin: 0.0, end: 1.0).animate(curved),
          child: child,
        ),
      );
    },
  );
}

final appRouterProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authNotifierProvider);

  return GoRouter(
    navigatorKey: _rootNavigatorKey,
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

      // Bottom navigation shell
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            MainShellScreen(navigationShell: navigationShell),
        branches: [
          // Tab 0 — Home
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.home,
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),
          // Tab 1 — Shop
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.shop,
                builder: (context, state) => const ShopScreen(),
              ),
            ],
          ),
          // Tab 2 — Workouts
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.workouts,
                builder: (context, state) => const WorkoutPlansScreen(),
              ),
            ],
          ),
          // Tab 3 — Profile
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.profile,
                builder: (context, state) => const ProfileScreen(),
              ),
            ],
          ),
        ],
      ),

      // Push navigation — slide from right
      GoRoute(
        path: AppRoutes.staffList,
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) => _slideTransition(
          state: state,
          child: const StaffListScreen(),
        ),
      ),
      GoRoute(
        path: AppRoutes.myOrders,
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) => _slideTransition(
          state: state,
          child: const MyOrdersScreen(),
        ),
      ),
      GoRoute(
        path: AppRoutes.myAppointments,
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) => _slideTransition(
          state: state,
          child: const MyAppointmentsScreen(),
        ),
      ),
      GoRoute(
        path: AppRoutes.leaderboard,
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) => _slideTransition(
          state: state,
          child: const LeaderboardScreen(),
        ),
      ),
      GoRoute(
        path: AppRoutes.editProfile,
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) => _slideTransition(
          state: state,
          child: const EditProfileScreen(),
        ),
      ),
      GoRoute(
        path: AppRoutes.cart,
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) => _slideTransition(
          state: state,
          child: const CartScreen(),
        ),
      ),
      GoRoute(
        path: AppRoutes.membership,
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) => _slideTransition(
          state: state,
          child: const MembershipScreen(),
        ),
      ),
      GoRoute(
        path: AppRoutes.bookAppointment,
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) {
          final staffId = int.parse(state.pathParameters['staffId']!);
          return _slideTransition(
            state: state,
            child: BookAppointmentScreen(staffId: staffId),
          );
        },
      ),

      // Detail/modal screens — slide up
      GoRoute(
        path: AppRoutes.productDetail,
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) {
          final id = int.parse(state.pathParameters['id']!);
          return _slideUpTransition(
            state: state,
            child: ProductDetailScreen(productId: id),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.staffDetail,
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) {
          final id = int.parse(state.pathParameters['id']!);
          return _slideUpTransition(
            state: state,
            child: StaffDetailScreen(staffId: id),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.orderDetail,
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) {
          final id = int.parse(state.pathParameters['id']!);
          return _slideUpTransition(
            state: state,
            child: OrderDetailScreen(orderId: id),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.orderConfirmation,
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) {
          final id = int.parse(state.pathParameters['id']!);
          return _slideUpTransition(
            state: state,
            child: OrderConfirmationScreen(orderId: id),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.appointmentDetail,
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) {
          final id = int.parse(state.pathParameters['id']!);
          return _slideUpTransition(
            state: state,
            child: AppointmentDetailScreen(appointmentId: id),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.workoutPlanDetail,
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) {
          final id = int.parse(state.pathParameters['id']!);
          return _slideUpTransition(
            state: state,
            child: WorkoutPlanDetailScreen(planId: id),
          );
        },
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
