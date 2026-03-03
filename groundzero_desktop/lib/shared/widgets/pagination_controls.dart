import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/constants/app_colors.dart';

class PaginationControls extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final int totalCount;
  final VoidCallback? onPrevious;
  final VoidCallback? onNext;

  const PaginationControls({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.totalCount,
    this.onPrevious,
    this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Ukupno: $totalCount',
          style: GoogleFonts.inter(
            fontSize: 13,
            color: AppColors.textSecondary,
          ),
        ),
        Row(
          children: [
            IconButton(
              onPressed: currentPage > 1 ? onPrevious : null,
              icon: Icon(
                Icons.chevron_left_rounded,
                color: currentPage > 1
                    ? AppColors.textPrimary
                    : AppColors.textHint,
              ),
              splashRadius: 18,
            ),
            Text(
              '$currentPage / $totalPages',
              style: GoogleFonts.inter(
                fontSize: 13,
                color: AppColors.textSecondary,
              ),
            ),
            IconButton(
              onPressed: currentPage < totalPages ? onNext : null,
              icon: Icon(
                Icons.chevron_right_rounded,
                color: currentPage < totalPages
                    ? AppColors.textPrimary
                    : AppColors.textHint,
              ),
              splashRadius: 18,
            ),
          ],
        ),
      ],
    );
  }
}
