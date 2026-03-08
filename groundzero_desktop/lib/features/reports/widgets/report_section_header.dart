import 'package:flutter/material.dart';

import '../../../core/constants/app_text_styles.dart';

class ReportSectionHeader extends StatelessWidget {
  final String title;

  const ReportSectionHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(title, style: AppTextStyles.heading3),
    );
  }
}
