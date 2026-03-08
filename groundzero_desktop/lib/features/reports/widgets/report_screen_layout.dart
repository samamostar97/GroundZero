import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import 'report_date_range_picker.dart';
import 'report_export_buttons.dart';

class ReportScreenLayout extends StatelessWidget {
  final String title;
  final DateTime from;
  final DateTime to;
  final ValueChanged<DateTime> onFromChanged;
  final ValueChanged<DateTime> onToChanged;
  final VoidCallback onApply;
  final bool isExporting;
  final VoidCallback onExportPdf;
  final VoidCallback onExportExcel;
  final bool isLoading;
  final String? error;
  final VoidCallback? onRetry;
  final List<Widget> children;

  const ReportScreenLayout({
    super.key,
    required this.title,
    required this.from,
    required this.to,
    required this.onFromChanged,
    required this.onToChanged,
    required this.onApply,
    required this.isExporting,
    required this.onExportPdf,
    required this.onExportExcel,
    required this.isLoading,
    this.error,
    this.onRetry,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header row
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
            child: Row(
              children: [
                Text(title, style: AppTextStyles.heading2),
                const Spacer(),
                ReportDateRangePicker(
                  from: from,
                  to: to,
                  onFromChanged: onFromChanged,
                  onToChanged: onToChanged,
                  onApply: onApply,
                ),
                const SizedBox(width: 16),
                ReportExportButtons(
                  isExporting: isExporting,
                  onExportPdf: onExportPdf,
                  onExportExcel: onExportExcel,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Content
          Expanded(
            child: _buildBody(),
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(color: AppColors.accent),
      );
    }

    if (error != null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, color: AppColors.error, size: 48),
            const SizedBox(height: 12),
            Text(error!, style: AppTextStyles.bodyMedium),
            if (onRetry != null) ...[
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: onRetry,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.accent,
                  foregroundColor: AppColors.onAccent,
                ),
                child: const Text('Pokušaj ponovo'),
              ),
            ],
          ],
        ),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }
}
