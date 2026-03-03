import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppShadows {
  AppShadows._();

  static const List<BoxShadow> card = [
    BoxShadow(color: Color(0x40000000), blurRadius: 8, offset: Offset(0, 2)),
  ];

  static const List<BoxShadow> elevated = [
    BoxShadow(color: Color(0x60000000), blurRadius: 16, offset: Offset(0, 4)),
  ];

  static const List<BoxShadow> accentGlow = [
    BoxShadow(color: AppColors.accentGlow, blurRadius: 20, spreadRadius: 0),
  ];
}
