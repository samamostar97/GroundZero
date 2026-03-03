import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_shadows.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/utils/image_utils.dart';

class StaffCard extends StatelessWidget {
  final int id;
  final String firstName;
  final String lastName;
  final String staffType;
  final String? profileImageUrl;
  final VoidCallback? onTap;

  const StaffCard({
    super.key,
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.staffType,
    this.profileImageUrl,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final fullUrl = ImageUtils.fullImageUrl(profileImageUrl);
    final initials =
        '${firstName.isNotEmpty ? firstName[0] : ''}${lastName.isNotEmpty ? lastName[0] : ''}'
            .toUpperCase();

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          boxShadow: AppShadows.card,
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Avatar area
            Expanded(
              child: Hero(
                tag: 'staff-image-$id',
                child: fullUrl != null
                    ? CachedNetworkImage(
                        imageUrl: fullUrl,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        placeholder: (_, _) => Container(
                          color: AppColors.inputFill,
                          child: Center(
                            child: Text(
                              initials,
                              style: AppTextStyles.heading2.copyWith(
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
                              style: AppTextStyles.heading2.copyWith(
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
                            style: AppTextStyles.heading2.copyWith(
                              color: AppColors.textHint,
                            ),
                          ),
                        ),
                      ),
              ),
            ),

            // Info
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  // Type badge
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: _typeColor(staffType).withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      _typeLabel(staffType),
                      style: AppTextStyles.bodySmall.copyWith(
                        color: _typeColor(staffType),
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),

                  // Name
                  Text(
                    '$firstName $lastName',
                    style: AppTextStyles.bodySmall.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static String _typeLabel(String staffType) {
    return switch (staffType) {
      'Trainer' => 'Trener',
      'Nutritionist' => 'Nutricionist',
      _ => staffType,
    };
  }

  static Color _typeColor(String staffType) {
    return switch (staffType) {
      'Trainer' => AppColors.accent,
      'Nutritionist' => AppColors.success,
      _ => AppColors.textHint,
    };
  }
}
