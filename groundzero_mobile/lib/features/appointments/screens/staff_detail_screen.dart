import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/utils/image_utils.dart';
import '../../../shared/widgets/error_display.dart';
import '../../../shared/widgets/primary_button.dart';
import '../providers/staff_provider.dart';

class StaffDetailScreen extends ConsumerWidget {
  final int staffId;

  const StaffDetailScreen({super.key, required this.staffId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final staffAsync = ref.watch(staffDetailProvider(staffId));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: staffAsync.whenOrNull(
          data: (staff) => Text(
            '${staff.firstName} ${staff.lastName}',
            style: AppTextStyles.heading3,
          ),
        ),
      ),
      body: staffAsync.when(
        loading: () => const Center(
          child: CircularProgressIndicator(color: AppColors.accent),
        ),
        error: (_, _) => ErrorDisplay(
          message: 'Greška pri učitavanju profila.',
          onRetry: () => ref.invalidate(staffDetailProvider(staffId)),
        ),
        data: (staff) {
          final fullUrl = ImageUtils.fullImageUrl(staff.profileImageUrl);
          final initials =
              '${staff.firstName.isNotEmpty ? staff.firstName[0] : ''}${staff.lastName.isNotEmpty ? staff.lastName[0] : ''}'
                  .toUpperCase();

          final typeLabel = staff.staffType == 'Trainer'
              ? 'Trener'
              : staff.staffType == 'Nutritionist'
                  ? 'Nutricionist'
                  : staff.staffType;
          final typeColor = staff.staffType == 'Trainer'
              ? AppColors.accent
              : AppColors.success;

          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              // Profile image
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: SizedBox(
                    width: 160,
                    height: 160,
                    child: fullUrl != null
                        ? CachedNetworkImage(
                            imageUrl: fullUrl,
                            fit: BoxFit.cover,
                            placeholder: (_, _) => Container(
                              color: AppColors.inputFill,
                              child: Center(
                                child: Text(
                                  initials,
                                  style: AppTextStyles.heading1.copyWith(
                                    color: AppColors.textHint,
                                  ),
                                ),
                              ),
                            ),
                            errorWidget: (_, _, _) => Container(
                              color: AppColors.inputFill,
                              child: Center(
                                child: Text(
                                  initials,
                                  style: AppTextStyles.heading1.copyWith(
                                    color: AppColors.textHint,
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Container(
                            color: AppColors.inputFill,
                            child: Center(
                              child: Text(
                                initials,
                                style: AppTextStyles.heading1.copyWith(
                                  color: AppColors.textHint,
                                ),
                              ),
                            ),
                          ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Name
              Center(
                child: Text(
                  '${staff.firstName} ${staff.lastName}',
                  style: AppTextStyles.heading2,
                ),
              ),
              const SizedBox(height: 8),

              // Type badge
              Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: typeColor.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    typeLabel,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: typeColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Info card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.border),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (staff.email.isNotEmpty) ...[
                      _InfoRow(
                        icon: Icons.email_outlined,
                        value: staff.email,
                      ),
                      const SizedBox(height: 10),
                    ],
                    if (staff.phone != null && staff.phone!.isNotEmpty) ...[
                      _InfoRow(
                        icon: Icons.phone_outlined,
                        value: staff.phone!,
                      ),
                      const SizedBox(height: 10),
                    ],
                  ],
                ),
              ),

              // Bio
              if (staff.bio != null && staff.bio!.isNotEmpty) ...[
                const SizedBox(height: 20),
                Text('O nama', style: AppTextStyles.heading3),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Text(
                    staff.bio!,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                      height: 1.5,
                    ),
                  ),
                ),
              ],

              const SizedBox(height: 32),

              // Book button
              PrimaryButton(
                label: 'Zakaži termin',
                onPressed: () =>
                    context.push('/book-appointment/${staff.id}'),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String value;

  const _InfoRow({required this.icon, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: AppColors.textHint, size: 18),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            value,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ),
      ],
    );
  }
}
