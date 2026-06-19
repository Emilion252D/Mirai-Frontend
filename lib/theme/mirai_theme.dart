import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MiraiColors {
  // Primary
  static const Color violet = Color(0xFF6C47C4);
  static const Color violetLight = Color(0xFFF0EDF8);
  static const Color violetMid = Color(0xFFDDD6F5);
  static const Color violetDark = Color(0xFF1A1430);

  // Background
  static const Color bg = Color(0xFFF7F5FC);
  static const Color white = Color(0xFFFFFFFF);

  // Text
  static const Color textPrimary = Color(0xFF1A1430);
  static const Color textSecondary = Color(0xFF7A6AAA);
  static const Color textMuted = Color(0xFFB0A0D0);

  // Border
  static const Color border = Color(0xFFE0D8F0);

  // Accents
  static const Color gold = Color(0xFFE8B96A);
  static const Color green = Color(0xFF1D9E75);
  static const Color pink = Color(0xFFE25393);
  static const Color red = Color(0xFFA32D2D);
}

class MiraiTheme {
  static ThemeData get theme => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: MiraiColors.violet,
          background: MiraiColors.bg,
        ),
        scaffoldBackgroundColor: MiraiColors.bg,
        textTheme: GoogleFonts.interTextTheme().copyWith(
          displayLarge: GoogleFonts.inter(
            fontSize: 28,
            fontWeight: FontWeight.w600,
            color: MiraiColors.textPrimary,
            letterSpacing: -0.5,
          ),
          headlineMedium: GoogleFonts.inter(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: MiraiColors.textPrimary,
          ),
          titleLarge: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: MiraiColors.textPrimary,
          ),
          titleMedium: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: MiraiColors.textPrimary,
          ),
          bodyLarge: GoogleFonts.inter(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: MiraiColors.textPrimary,
          ),
          bodyMedium: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: MiraiColors.textSecondary,
          ),
          bodySmall: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: MiraiColors.textMuted,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: MiraiColors.violet,
            foregroundColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            textStyle: GoogleFonts.inter(
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: MiraiColors.violet,
            side: const BorderSide(color: MiraiColors.violetMid, width: 1.5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            textStyle: GoogleFonts.inter(
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: MiraiColors.violet,
          foregroundColor: Colors.white,
          elevation: 0,
          titleTextStyle: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      );
}
