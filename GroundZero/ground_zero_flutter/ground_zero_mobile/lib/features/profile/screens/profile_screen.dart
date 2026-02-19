import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ground_zero_core/ground_zero_core.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
        CircleAvatar(radius: 48, child: Icon(Icons.person, size: 48, color: Theme.of(context).colorScheme.primary)),
        const SizedBox(height: 24),
        Text('Member Profile', style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 32),
        FilledButton.tonalIcon(
          onPressed: () => ref.read(authStateProvider.notifier).logout(),
          icon: const Icon(Icons.logout), label: const Text('Logout'),
        ),
      ])),
    );
  }
}