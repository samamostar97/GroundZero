import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';

class ReportDataTable extends StatelessWidget {
  final List<String> columns;
  final List<DataRow> rows;

  const ReportDataTable({
    super.key,
    required this.columns,
    required this.rows,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: ConstrainedBox(
                constraints: BoxConstraints(minWidth: constraints.maxWidth),
                child: DataTable(
                  headingRowColor: WidgetStateProperty.all(AppColors.surfaceHigh),
                  dataRowColor: WidgetStateProperty.all(AppColors.surface),
                  headingTextStyle: AppTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.accent,
                  ),
                  dataTextStyle: AppTextStyles.bodyMedium,
                  columnSpacing: 32,
                  horizontalMargin: 16,
                  columns: columns
                      .map((c) => DataColumn(label: Text(c)))
                      .toList(),
                  rows: rows,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
