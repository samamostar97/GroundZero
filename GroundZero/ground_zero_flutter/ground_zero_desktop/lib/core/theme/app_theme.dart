import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  AppTheme._();
  static const _seed = Color(0xFF1E3A5F);

  static ThemeData get light => ThemeData(
    useMaterial3: true, colorSchemeSeed: _seed, brightness: Brightness.light,
    textTheme: GoogleFonts.interTextTheme(),
    cardTheme: CardThemeData(elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
  );

  static ThemeData get dark => ThemeData(
    useMaterial3: true, colorSchemeSeed: _seed, brightness: Brightness.dark,
    textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme),
    cardTheme: CardThemeData(elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
  );
}