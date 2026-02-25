import 'package:flutter/material.dart';

enum AppThemeType {
  obsidianGold,
  pureIvory,
  classicSepia,
  slateMist,
}

class AppPalette {
  final Color primary;
  final Color accent;
  final Color background;
  final Color text;
  final Color secondaryText;
  final Brightness brightness;

  const AppPalette({
    required this.primary,
    required this.accent,
    required this.background,
    required this.text,
    required this.secondaryText,
    required this.brightness,
  });

  static const obsidianGold = AppPalette(
    primary: Color(0xFF1E1E1E),
    accent: Color(0xFFA67C00),
    background: Color(0xFF121212),
    text: Color(0xFFE0E0E0),
    secondaryText: Color(0xFF757575),
    brightness: Brightness.dark,
  );

  static const pureIvory = AppPalette(
    primary: Color(0xFF1A1A1A),
    accent: Color(0xFF000000),
    background: Color(0xFFFFFFFF),
    text: Color(0xFF1A1A1A),
    secondaryText: Color(0xFF757575),
    brightness: Brightness.light,
  );

  static const classicSepia = AppPalette(
    primary: Color(0xFF4E342E),
    accent: Color(0xFF4A4A4A),
    background: Color(0xFFF4ECD8),
    text: Color(0xFF4E342E),
    secondaryText: Color(0xFF795548),
    brightness: Brightness.light,
  );

  static const slateMist = AppPalette(
    primary: Color(0xFF334155),
    accent: Color(0xFF334155),
    background: Color(0xFFF0F2F5),
    text: Color(0xFF1E293B),
    secondaryText: Color(0xFF64748B),
    brightness: Brightness.light,
  );

  factory AppPalette.fromType(AppThemeType type) {
    switch (type) {
      case AppThemeType.obsidianGold:
        return obsidianGold;
      case AppThemeType.pureIvory:
        return pureIvory;
      case AppThemeType.classicSepia:
        return classicSepia;
      case AppThemeType.slateMist:
        return slateMist;
    }
  }
}

class AppColors {
  // Legacy support for auth pages if they use static colors
  static const Color primary = Color(0xFF1E1E1E);
  static const Color accent = Color(0xFFA67C00);
  static const Color lightBg = Color(0xFFF9F9F9);
  static const Color greyText = Color(0xFF757575);
}
