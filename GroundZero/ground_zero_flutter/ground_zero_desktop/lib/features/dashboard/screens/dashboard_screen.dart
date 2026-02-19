import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.all(24), child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Dashboard', style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: 24),
        Wrap(spacing: 16, runSpacing: 16, children: [
          _StatCard(title: 'Total Products', value: '--', icon: Icons.inventory_2, color: Colors.blue),
          _StatCard(title: 'Active', value: '--', icon: Icons.check_circle, color: Colors.green),
          _StatCard(title: 'Out of Stock', value: '--', icon: Icons.warning, color: Colors.orange),
          _StatCard(title: 'Users', value: '--', icon: Icons.people, color: Colors.purple),
        ]),
      ],
    ));
  }
}

class _StatCard extends StatelessWidget {
  final String title; final String value; final IconData icon; final Color color;
  const _StatCard({required this.title, required this.value, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) => SizedBox(width: 220, child: Card(child: Padding(
    padding: const EdgeInsets.all(20), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Icon(icon, color: color, size: 32), const SizedBox(height: 12),
      Text(value, style: Theme.of(context).textTheme.headlineMedium),
      Text(title, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey)),
    ]))));
}