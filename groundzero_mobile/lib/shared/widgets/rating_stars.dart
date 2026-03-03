import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

class RatingStars extends StatelessWidget {
  final double rating;
  final double size;
  final bool interactive;
  final ValueChanged<int>? onRatingChanged;

  const RatingStars({
    super.key,
    required this.rating,
    this.size = 18,
    this.interactive = false,
    this.onRatingChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        final starValue = index + 1;
        IconData icon;
        Color color;

        if (rating >= starValue) {
          icon = Icons.star_rounded;
          color = AppColors.warning;
        } else if (rating >= starValue - 0.5) {
          icon = Icons.star_half_rounded;
          color = AppColors.warning;
        } else {
          icon = Icons.star_outline_rounded;
          color = AppColors.textHint;
        }

        final star = Icon(icon, size: size, color: color);

        if (interactive) {
          return GestureDetector(
            onTap: () => onRatingChanged?.call(starValue),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: star,
            ),
          );
        }

        return star;
      }),
    );
  }
}
