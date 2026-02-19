import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ground_zero_core/ground_zero_core.dart';

class ShellLayout extends ConsumerWidget {
  final Widget child;
  const ShellLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final location = GoRouterState.of(context).matchedLocation;
    final selectedIndex = switch (location) { '/dashboard' => 0, '/products' => 1, _ => 0 };

    return Scaffold(
      body: Row(children: [
        NavigationRail(
          selectedIndex: selectedIndex,
          onDestinationSelected: (i) {
            final routes = ['/dashboard', '/products'];
            context.go(routes[i]);
          },
          extended: MediaQuery.of(context).size.width > 1200,
          leading: Padding(
            padding: const EdgeInsets.all(16),
            child: Icon(Icons.admin_panel_settings, size: 32, color: Theme.of(context).colorScheme.primary),
          ),
          trailing: Expanded(child: Align(alignment: Alignment.bottomCenter, child: Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: IconButton(icon: const Icon(Icons.logout),
              onPressed: () => ref.read(authStateProvider.notifier).logout()),
          ))),
          destinations: const [
            NavigationRailDestination(icon: Icon(Icons.dashboard_outlined), selectedIcon: Icon(Icons.dashboard), label: Text('Dashboard')),
            NavigationRailDestination(icon: Icon(Icons.inventory_2_outlined), selectedIcon: Icon(Icons.inventory_2), label: Text('Products')),
          ],
        ),
        const VerticalDivider(width: 1, thickness: 1),
        Expanded(child: child),
      ]),
    );
  }
}