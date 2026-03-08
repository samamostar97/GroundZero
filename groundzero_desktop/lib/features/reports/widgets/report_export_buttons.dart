import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';

class ReportExportButtons extends StatelessWidget {
  final bool isExporting;
  final VoidCallback onExportPdf;
  final VoidCallback onExportExcel;

  const ReportExportButtons({
    super.key,
    required this.isExporting,
    required this.onExportPdf,
    required this.onExportExcel,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _ExportButton(
          icon: Icons.picture_as_pdf,
          label: 'PDF',
          isLoading: isExporting,
          onPressed: onExportPdf,
        ),
        const SizedBox(width: 8),
        _ExportButton(
          icon: Icons.table_chart,
          label: 'Excel',
          isLoading: isExporting,
          onPressed: onExportExcel,
        ),
      ],
    );
  }
}

class _ExportButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isLoading;
  final VoidCallback onPressed;

  const _ExportButton({
    required this.icon,
    required this.label,
    required this.isLoading,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 38,
      child: OutlinedButton.icon(
        onPressed: isLoading ? null : onPressed,
        icon: isLoading
            ? const SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: AppColors.accent,
                ),
              )
            : Icon(icon, size: 18),
        label: Text(label, style: AppTextStyles.bodyMedium.copyWith(fontSize: 13)),
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.textPrimary,
          side: const BorderSide(color: AppColors.border),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12),
        ),
      ),
    );
  }
}
