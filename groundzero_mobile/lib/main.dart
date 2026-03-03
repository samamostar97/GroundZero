import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import 'core/routing/app_router.dart';
import 'core/theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey =
      'pk_test_51SvL7dBlrIi9HZmrpay9Tog3KFDvHRhlqN79lwDSk6eEY28g9AX5Lh9jCo73WpvKoy1uOPishDeoIkj2rFCy20wL00kgziPzD3';
  runApp(const ProviderScope(child: GroundZeroApp()));
}

class GroundZeroApp extends ConsumerWidget {
  const GroundZeroApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      title: 'GroundZero',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
      routerConfig: router,
    );
  }
}
