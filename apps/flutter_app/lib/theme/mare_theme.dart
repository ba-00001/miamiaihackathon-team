import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MareColors {
  static const ink = Color(0xFF1E1A17);
  static const sand = Color(0xFFF9F4EB);
  static const pearl = Color(0xFFFFFCF6);
  static const gold = Color(0xFFF5C94C);
  static const espresso = Color(0xFF5E4B3E);
  static const sage = Color(0xFFDEE5D3);
  static const rose = Color(0xFFF3E0D9);
}

ThemeData buildMareTheme() {
  final textTheme = GoogleFonts.manropeTextTheme().copyWith(
    headlineLarge: GoogleFonts.cormorantGaramond(
      fontSize: 42,
      fontWeight: FontWeight.w700,
      color: MareColors.ink,
    ),
    headlineMedium: GoogleFonts.cormorantGaramond(
      fontSize: 28,
      fontWeight: FontWeight.w700,
      color: MareColors.ink,
    ),
    titleLarge: GoogleFonts.manrope(
      fontSize: 18,
      fontWeight: FontWeight.w700,
      color: MareColors.ink,
    ),
    bodyLarge: GoogleFonts.manrope(
      fontSize: 15,
      height: 1.55,
      color: MareColors.ink,
    ),
    bodyMedium: GoogleFonts.manrope(
      fontSize: 14,
      height: 1.45,
      color: MareColors.espresso,
    ),
  );

  return ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: MareColors.sand,
    textTheme: textTheme,
    colorScheme: ColorScheme.fromSeed(
      seedColor: MareColors.gold,
      brightness: Brightness.light,
      surface: MareColors.pearl,
      primary: MareColors.ink,
      secondary: MareColors.gold,
    ),
    cardTheme: CardThemeData(
      color: MareColors.pearl,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(28),
        side: const BorderSide(color: Color(0xFFE8DED0)),
      ),
    ),
  );
}
