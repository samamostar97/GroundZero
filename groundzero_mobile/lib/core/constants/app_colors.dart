import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Backgrounds (elevation levels)
  static const Color background = Color(0xFF0A0A0A);
  static const Color surfaceLow = Color(0xFF121212);
  static const Color surface = Color(0xFF161616);
  static const Color surfaceHigh = Color(0xFF1E1E1E);
  static const Color inputFill = Color(0xFF1E1E1E);

  // Accent
  static const Color accent = Color(0xFFCCFF00);
  static const Color accentDark = Color(0xFFB8E600);
  static const Color onAccent = Color(0xFF0D0D0D);

  // Text
  static const Color textPrimary = Color(0xFFE8E8E8);
  static const Color textSecondary = Color(0xFFB0B0B0);
  static const Color textHint = Color(0xFF707070);

  // Borders
  static const Color border = Color(0xFF333333);
  static const Color borderFocused = accent;

  // Status
  static const Color error = Color(0xFFFF4D4D);
  static const Color success = Color(0xFF4DFF88);
  static const Color warning = Color(0xFFFFBB33);

  // Glow
  static const Color accentGlow = Color(0x12CCFF00);
}
