import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../features/auth/providers/auth_provider.dart';
import '../../features/auth/providers/user_provider.dart';
import '../../shared/widgets/primary_button.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(userNotifierProvider);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: userAsync.when(
            loading: () => const Center(
              child: CircularProgressIndicator(color: AppColors.accent),
            ),
            error: (error, _) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Greška pri učitavanju profila.',
                    style: AppTextStyles.bodyLarge,
                  ),
                  const SizedBox(height: 16),
                  PrimaryButton(
                    label: 'Pokušaj ponovo',
                    onPressed: () =>
                        ref.read(userNotifierProvider.notifier).refresh(),
                  ),
                ],
              ),
            ),
            data: (user) {
              if (user == null) {
                return const Center(
                  child: CircularProgressIndicator(color: AppColors.accent),
                );
              }

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Spacer(),

                  // Welcome message
                  Text(
                    'Dobrodošli,',
                    style: AppTextStyles.bodyLarge.copyWith(
                      color: AppColors.textSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${user.firstName} ${user.lastName}!',
                    style: AppTextStyles.heading1.copyWith(
                      color: AppColors.accent,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),

                  // User info card
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Column(
                      children: [
                        _InfoRow(label: 'Email', value: user.email),
                        const Divider(
                          color: AppColors.border,
                          height: 24,
                        ),
                        _InfoRow(
                          label: 'Level',
                          value: '${user.level}',
                        ),
                        const Divider(
                          color: AppColors.border,
                          height: 24,
                        ),
                        _InfoRow(label: 'XP', value: '${user.xp}'),
                      ],
                    ),
                  ),

                  const Spacer(),

                  // Logout button
                  PrimaryButton(
                    label: 'Odjava',
                    onPressed: () {
                      ref.read(authNotifierProvider.notifier).logout();
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        Text(
          value,
          style: AppTextStyles.bodyMedium.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
