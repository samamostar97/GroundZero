import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';

class OrderStatusBadge extends StatelessWidget {
  final int status;

  const OrderStatusBadge({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final (label, color) = _statusInfo(status);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: AppTextStyles.bodySmall.copyWith(
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  static (String, Color) _statusInfo(int status) {
    return switch (status) {
      0 => ('Na čekanju', AppColors.warning),
      1 => ('Potvrđeno', AppColors.accent),
      2 => ('Poslano', const Color(0xFF64B5F6)),
      3 => ('Dostavljeno', AppColors.success),
      4 => ('Otkazano', AppColors.error),
      _ => ('Nepoznato', AppColors.textHint),
    };
  }

  static String statusLabel(int status) {
    return _statusInfo(status).$1;
  }
}
