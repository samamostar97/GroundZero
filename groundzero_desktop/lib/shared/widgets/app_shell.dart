import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/appointments/screens/appointments_screen.dart';
import '../../features/auth/providers/auth_provider.dart';
import '../../features/categories/screens/categories_screen.dart';
import '../../features/dashboard/screens/dashboard_screen.dart';
import '../../features/gym_visits/screens/gym_visits_screen.dart';
import '../../features/membership_plans/screens/membership_plans_screen.dart';
import '../../features/memberships/screens/memberships_screen.dart';
import '../../features/orders/screens/orders_screen.dart';
import '../../features/products/screens/products_screen.dart';
import '../../features/reports/screens/appointment_report_screen.dart';
import '../../features/reports/screens/gamification_report_screen.dart';
import '../../features/reports/screens/product_report_screen.dart';
import '../../features/reports/screens/revenue_report_screen.dart';
import '../../features/reports/screens/user_report_screen.dart';
import '../../features/staff/screens/staff_screen.dart';
import '../../features/users/screens/users_screen.dart';
import 'app_sidebar.dart';
import 'top_tab_bar.dart';

// Current sidebar section
final sidebarIndexProvider = StateProvider<int>((ref) => 0);

// Current tab within a section
final tabIndexProvider = StateProvider<int>((ref) => 0);

// Tab definitions per sidebar section
const _sectionTabs = <int, List<String>>{
  // 0 = Dashboard — no tabs
  1: ['Korisnici', 'Osoblje', 'Proizvodi', 'Kategorije', 'Planovi članarina'],
  2: ['Narudžbe', 'Termini', 'Check-in / Check-out', 'Članarine'],
  3: ['Prihodi', 'Proizvodi', 'Korisnici', 'Termini', 'Gamifikacija'],
};

class AppShell extends ConsumerWidget {
  const AppShell({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sidebarIndex = ref.watch(sidebarIndexProvider);
    final tabIndex = ref.watch(tabIndexProvider);
    final tabs = _sectionTabs[sidebarIndex];

    return Scaffold(
      body: Row(
        children: [
          // Sidebar
          AppSidebar(
            selectedIndex: sidebarIndex,
            onItemSelected: (index) {
              ref.read(sidebarIndexProvider.notifier).state = index;
              ref.read(tabIndexProvider.notifier).state = 0;
            },
            onLogout: () {
              ref.read(authNotifierProvider.notifier).logout();
            },
          ),

          // Main content area
          Expanded(
            child: Column(
              children: [
                // Top tab bar (only for sections with tabs)
                if (tabs != null)
                  TopTabBar(
                    tabs: tabs,
                    selectedIndex: tabIndex,
                    onTabSelected: (index) {
                      ref.read(tabIndexProvider.notifier).state = index;
                    },
                  ),

                // Content
                Expanded(
                  child: _buildContent(sidebarIndex, tabIndex),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(int sidebarIndex, int tabIndex) {
    switch (sidebarIndex) {
      case 0:
        return const DashboardScreen();

      // Upravljanje
      case 1:
        switch (tabIndex) {
          case 0:
            return const UsersScreen();
          case 1:
            return const StaffScreen();
          case 2:
            return const ProductsScreen();
          case 3:
            return const CategoriesScreen();
          case 4:
            return const MembershipPlansScreen();
          default:
            return const UsersScreen();
        }

      // Operacije
      case 2:
        switch (tabIndex) {
          case 0:
            return const OrdersScreen();
          case 1:
            return const AppointmentsScreen();
          case 2:
            return const GymVisitsScreen();
          case 3:
            return const MembershipsScreen();
          default:
            return const OrdersScreen();
        }

      // Izvještaji
      case 3:
        switch (tabIndex) {
          case 0:
            return const RevenueReportScreen();
          case 1:
            return const ProductReportScreen();
          case 2:
            return const UserReportScreen();
          case 3:
            return const AppointmentReportScreen();
          case 4:
            return const GamificationReportScreen();
          default:
            return const RevenueReportScreen();
        }

      default:
        return const DashboardScreen();
    }
  }
}
