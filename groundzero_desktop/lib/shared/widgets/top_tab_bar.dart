import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/constants/app_colors.dart';

class TopTabBar extends StatelessWidget {
  final List<String> tabs;
  final int selectedIndex;
  final ValueChanged<int> onTabSelected;

  const TopTabBar({
    super.key,
    required this.tabs,
    required this.selectedIndex,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: const BoxDecoration(
        color: AppColors.background,
        border: Border(
          bottom: BorderSide(color: AppColors.border, width: 0.5),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(tabs.length, (index) {
          final isSelected = index == selectedIndex;
          return _TabItem(
            label: tabs[index],
            isSelected: isSelected,
            onTap: () => onTabSelected(index),
          );
        }),
      ),
    );
  }
}

class _TabItem extends StatefulWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _TabItem({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<_TabItem> createState() => _TabItemState();
}

class _TabItemState extends State<_TabItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.only(left: 4, right: 4, top: 14, bottom: 8),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(
              color: widget.isSelected
                  ? AppColors.accent.withValues(alpha: 0.1)
                  : _isHovered
                      ? AppColors.surfaceHigh
                      : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              widget.label,
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight:
                    widget.isSelected ? FontWeight.w600 : FontWeight.w500,
                color: widget.isSelected
                    ? AppColors.accent
                    : _isHovered
                        ? AppColors.textPrimary
                        : AppColors.textSecondary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
