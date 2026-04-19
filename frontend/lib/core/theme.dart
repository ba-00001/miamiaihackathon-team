import 'package:flutter/material.dart';

class AppColors {
  static const Color bg = Color(0xFF09090B);
  static const Color surface = Color(0xFF131316);
  static const Color surfaceLight = Color(0xFF1C1C21);
  static const Color border = Color(0xFF27272A);
  static const Color accent = Color(0xFF7C3AED);
  static const Color accentLight = Color(0xFFA78BFA);
  static const Color success = Color(0xFF22C55E);
  static const Color error = Color(0xFFEF4444);
  static const Color textPrimary = Color(0xFFF4F4F5);
  static const Color textSecondary = Color(0xFFA1A1AA);
  static const Color textMuted = Color(0xFF71717A);
}

final ThemeData appTheme = ThemeData.dark().copyWith(
  scaffoldBackgroundColor: AppColors.bg,
  cardColor: AppColors.surface,
  primaryColor: AppColors.accent,
  colorScheme: const ColorScheme.dark(
    primary: AppColors.accent,
    secondary: AppColors.accentLight,
    surface: AppColors.surface,
    error: AppColors.error,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.transparent,
    elevation: 0,
    titleTextStyle: TextStyle(
      fontFamily: 'Inter',
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: AppColors.textPrimary,
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColors.surfaceLight,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: AppColors.border),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: AppColors.border),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: AppColors.accent, width: 1.5),
    ),
    labelStyle: const TextStyle(color: AppColors.textSecondary, fontSize: 13),
    hintStyle: const TextStyle(color: AppColors.textMuted, fontSize: 13),
    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.accent,
      foregroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
    ),
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: AppColors.textPrimary),
    bodyMedium: TextStyle(color: AppColors.textSecondary),
    bodySmall: TextStyle(color: AppColors.textMuted),
  ),
);