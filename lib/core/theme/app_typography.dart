import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ieee_app/core/theme/app_colors.dart';

class AppTypography {
  AppTypography._();

  static const String fontFamily = 'Inter';

  static TextTheme get lightTextTheme => GoogleFonts.interTextTheme().copyWith(
        displaySmall: const TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w900,
          height: 1.1,
          letterSpacing: -1.5,
          color: AppColors.premiumNavy,
        ),
        headlineLarge: const TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w900,
          letterSpacing: -1.2,
          color: AppColors.premiumNavy,
        ),
        headlineMedium: const TextStyle(
          fontSize: 26,
          fontWeight: FontWeight.w900,
          letterSpacing: -0.8,
          color: AppColors.premiumNavy,
        ),
        headlineSmall: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w900,
          letterSpacing: -0.5,
          color: AppColors.premiumNavy,
        ),
        titleLarge: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w900,
          letterSpacing: -0.2,
          color: AppColors.premiumNavy,
        ),
        titleMedium: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w800,
          color: AppColors.premiumNavy,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: AppColors.premiumNavy.withOpacity(0.9),
          height: 1.6,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: AppColors.premiumNavy.withOpacity(0.8),
          height: 1.5,
        ),
        bodySmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: AppColors.premiumNavy.withOpacity(0.6),
        ),
        labelSmall: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w900,
          letterSpacing: 1.2,
          color: AppColors.premiumNavy.withOpacity(0.7),
        ),
      );

  static TextTheme get darkTextTheme => GoogleFonts.interTextTheme().copyWith(
        displaySmall: const TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w600,
          height: 1.2,
          color: AppColors.textDarkTheme,
        ),
        headlineSmall: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: AppColors.textDarkTheme,
        ),
        titleLarge: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: AppColors.textDarkTheme,
        ),
        bodyLarge: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: AppColors.textDarkTheme,
        ),
        bodyMedium: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: AppColors.textMediumTheme,
        ),
        bodySmall: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: AppColors.textMediumTheme,
        ),
        labelSmall: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w400,
          color: AppColors.textMediumTheme,
        ),
      );
}
