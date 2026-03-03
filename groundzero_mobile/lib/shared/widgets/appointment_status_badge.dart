import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';

class AppointmentStatusBadge extends StatelessWidget {
  final String status;

  const AppointmentStatusBadge({super.key, required this.status});

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

  static (String, Color) _statusInfo(String status) {
    return switch (status) {
      'Pending' => ('Na čekanju', AppColors.warning),
      'Confirmed' => ('Potvrđeno', AppColors.accent),
      'Completed' => ('Završeno', AppColors.success),
      'Cancelled' => ('Otkazano', AppColors.error),
      _ => ('Nepoznato', AppColors.textHint),
    };
  }

  static String statusLabel(String status) {
    return _statusInfo(status).$1;
  }
}
