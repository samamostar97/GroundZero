import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';

class ReportBarChart extends StatelessWidget {
  final List<String> labels;
  final List<double> values;
  final double? maxY;
  final String? tooltipSuffix;
  final Color? barColor;
  final double barWidth;

  const ReportBarChart({
    super.key,
    required this.labels,
    required this.values,
    this.maxY,
    this.tooltipSuffix,
    this.barColor,
    this.barWidth = 18,
  });

  @override
  Widget build(BuildContext context) {
    if (values.isEmpty) {
      return Center(
        child: Text('Nema podataka', style: AppTextStyles.bodySmall),
      );
    }

    final effectiveMaxY = maxY ??
        (values.reduce((a, b) => a > b ? a : b) * 1.2).ceilToDouble();
    final color = barColor ?? AppColors.accent;

    return BarChart(
      BarChartData(
        maxY: effectiveMaxY == 0 ? 10 : effectiveMaxY,
        barTouchData: BarTouchData(
          touchTooltipData: BarTouchTooltipData(
            tooltipBorderRadius: BorderRadius.circular(8),
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              return BarTooltipItem(
                '${rod.toY.toStringAsFixed(rod.toY == rod.toY.roundToDouble() ? 0 : 2)}${tooltipSuffix ?? ''}',
                AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              );
            },
          ),
        ),
        titlesData: FlTitlesData(
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 36,
              getTitlesWidget: (value, meta) {
                final index = value.toInt();
                if (index < 0 || index >= labels.length) {
                  return const SizedBox.shrink();
                }
                return Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    labels[index],
                    style: AppTextStyles.bodySmall.copyWith(fontSize: 10),
                    textAlign: TextAlign.center,
                  ),
                );
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 48,
              getTitlesWidget: (value, meta) {
                if (value == meta.max || value == meta.min) {
                  return const SizedBox.shrink();
                }
                return Text(
                  _formatNumber(value),
                  style: AppTextStyles.bodySmall.copyWith(fontSize: 10),
                );
              },
            ),
          ),
        ),
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          horizontalInterval: effectiveMaxY == 0 ? 1 : effectiveMaxY / 4,
          getDrawingHorizontalLine: (value) => FlLine(
            color: AppColors.border.withValues(alpha: 0.5),
            strokeWidth: 0.5,
          ),
        ),
        borderData: FlBorderData(show: false),
        barGroups: List.generate(
          values.length,
          (i) => BarChartGroupData(
            x: i,
            barRods: [
              BarChartRodData(
                toY: values[i],
                color: color,
                width: barWidth,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatNumber(double value) {
    if (value >= 1000000) return '${(value / 1000000).toStringAsFixed(1)}M';
    if (value >= 1000) return '${(value / 1000).toStringAsFixed(1)}K';
    return value.toStringAsFixed(value == value.roundToDouble() ? 0 : 1);
  }
}
