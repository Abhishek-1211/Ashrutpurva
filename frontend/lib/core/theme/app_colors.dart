import 'package:flutter/material.dart';

enum AppThemeType {
  koraClassic,
  midnightMushaira,
  dhartiEarth,
  monsoonMist,
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

  static const koraClassic = AppPalette(
    primary: Color(0xFF0F172A), // Indo-Blue
    accent: Color(0xFF1E293B),
    background: Color(0xFFFDFCF8), // Paper
    text: Color(0xFF1A1A1A), // Ink
    secondaryText: Color(0xFF64748B),
    brightness: Brightness.light,
  );

  static const midnightMushaira = AppPalette(
    primary: Color(0xFF9F8170), // Rosewood
    accent: Color(0xFFC4A484),
    background: Color(0xFF0F1115), // Midnight
    text: Color(0xFFE2E8F0), // Starlight
    secondaryText: Color(0xFF94A3B8),
    brightness: Brightness.dark,
  );

  static const dhartiEarth = AppPalette(
    primary: Color(0xFFA0522D), // Terracotta
    accent: Color(0xFF8B4513),
    background: Color(0xFFF4ECE1), // Clay
    text: Color(0xFF2D241E), // Earth
    secondaryText: Color(0xFF5D4037),
    brightness: Brightness.light,
  );

  static const monsoonMist = AppPalette(
    primary: Color(0xFF6D8A8D), // Eucalyptus
    accent: Color(0xFF4A5568),
    background: Color(0xFFF0F4F2), // Sage
    text: Color(0xFF2D3748), // Cool Grey
    secondaryText: Color(0xFF718096),
    brightness: Brightness.light,
  );

  factory AppPalette.fromType(AppThemeType type) {
    switch (type) {
      case AppThemeType.koraClassic:
        return koraClassic;
      case AppThemeType.midnightMushaira:
        return midnightMushaira;
      case AppThemeType.dhartiEarth:
        return dhartiEarth;
      case AppThemeType.monsoonMist:
        return monsoonMist;
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
