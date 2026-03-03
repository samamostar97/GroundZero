import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_shadows.dart';
import '../../core/constants/app_text_styles.dart';
import 'rating_stars.dart';

class ReviewCard extends StatelessWidget {
  final String userName;
  final int rating;
  final String? comment;
  final DateTime createdAt;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const ReviewCard({
    super.key,
    required this.userName,
    required this.rating,
    this.comment,
    required this.createdAt,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(10),
        boxShadow: AppShadows.card,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  userName,
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              if (onEdit != null || onDelete != null) ...[
                if (onEdit != null)
                  SizedBox(
                    width: 28,
                    height: 28,
                    child: IconButton(
                      onPressed: onEdit,
                      icon: const Icon(Icons.edit_outlined, size: 16),
                      padding: EdgeInsets.zero,
                      color: AppColors.textHint,
                      splashRadius: 16,
                    ),
                  ),
                if (onDelete != null)
                  SizedBox(
                    width: 28,
                    height: 28,
                    child: IconButton(
                      onPressed: onDelete,
                      icon: const Icon(Icons.delete_outline, size: 16),
                      padding: EdgeInsets.zero,
                      color: AppColors.error,
                      splashRadius: 16,
                    ),
                  ),
                const SizedBox(width: 4),
              ],
              RatingStars(rating: rating.toDouble(), size: 14),
            ],
          ),
          if (comment != null && comment!.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              comment!,
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
          const SizedBox(height: 8),
          Text(
            _formatDate(createdAt),
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textHint,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}.${date.month}.${date.year}.';
  }
}
