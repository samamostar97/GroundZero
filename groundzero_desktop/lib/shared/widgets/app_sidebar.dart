import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/constants/app_colors.dart';

class SidebarItem {
  final String label;
  final IconData icon;

  const SidebarItem({required this.label, required this.icon});
}

class AppSidebar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemSelected;
  final VoidCallback onLogout;

  static const items = [
    SidebarItem(label: 'Dashboard', icon: Icons.dashboard_rounded),
    SidebarItem(label: 'Upravljanje', icon: Icons.settings_rounded),
    SidebarItem(label: 'Operacije', icon: Icons.assignment_rounded),
    SidebarItem(label: 'Izvještaji', icon: Icons.bar_chart_rounded),
  ];

  const AppSidebar({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      decoration: const BoxDecoration(
        color: AppColors.sidebarBg,
        border: Border(
          right: BorderSide(color: AppColors.border, width: 0.5),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 24),

          // Logo
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: AppColors.accent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.fitness_center_rounded,
                    color: AppColors.onAccent,
                    size: 16,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'GROUNDZERO',
                    style: GoogleFonts.barlowCondensed(
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                      color: AppColors.accent,
                      letterSpacing: 2,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 36),

          // Navigation items
          ...List.generate(items.length, (index) {
            final item = items[index];
            final isSelected = index == selectedIndex;

            return _SidebarTile(
              icon: item.icon,
              label: item.label,
              isSelected: isSelected,
              onTap: () => onItemSelected(index),
            );
          }),

          const Spacer(),

          // Logout
          _SidebarTile(
            icon: Icons.logout_rounded,
            label: 'Odjava',
            isSelected: false,
            onTap: onLogout,
            isDestructive: true,
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class _SidebarTile extends StatefulWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final bool isDestructive;

  const _SidebarTile({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
    this.isDestructive = false,
  });

  @override
  State<_SidebarTile> createState() => _SidebarTileState();
}

class _SidebarTileState extends State<_SidebarTile> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final color = widget.isDestructive
        ? AppColors.error
        : widget.isSelected
            ? AppColors.accent
            : _isHovered
                ? AppColors.textPrimary
                : AppColors.textSecondary;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: widget.isSelected
                ? AppColors.sidebarActive
                : _isHovered
                    ? AppColors.sidebarActive.withValues(alpha: 0.5)
                    : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border: widget.isSelected
                ? Border(
                    left: BorderSide(color: AppColors.accent, width: 3),
                  )
                : null,
          ),
          child: Row(
            children: [
              Icon(widget.icon, color: color, size: 20),
              const SizedBox(width: 12),
              Text(
                widget.label,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight:
                      widget.isSelected ? FontWeight.w600 : FontWeight.w500,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
