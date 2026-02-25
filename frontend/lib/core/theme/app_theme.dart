import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData createTheme(AppPalette palette) {
    return ThemeData(
      useMaterial3: true,
      brightness: palette.brightness,
      colorScheme: ColorScheme.fromSeed(
        seedColor: palette.primary,
        primary: palette.primary,
        secondary: palette.accent,
        surface: palette.background,
        brightness: palette.brightness,
      ),
      scaffoldBackgroundColor: palette.background,
      appBarTheme: AppBarTheme(
        backgroundColor: palette.background,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: palette.text,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
        iconTheme: IconThemeData(color: palette.text),
      ),
      textTheme: TextTheme(
        displayLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: palette.text,
          letterSpacing: -0.5,
        ),
        bodyLarge: TextStyle(
          fontSize: 18,
          color: palette.text,
          height: 1.6,
        ),
        bodyMedium: TextStyle(
          fontSize: 16,
          color: palette.secondaryText,
          height: 1.4,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: palette.primary,
          foregroundColor: palette.brightness == Brightness.dark ? Colors.white : palette.background,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }

  // Legacy static getters for back-compatibility during migration
  static ThemeData get lightTheme => createTheme(AppPalette.pureIvory);
  static ThemeData get darkTheme => createTheme(AppPalette.obsidianGold);
}
