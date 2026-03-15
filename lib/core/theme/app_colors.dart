import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Premium Neo-Brutalism Palette
  static const Color premiumBackground = Color(0xFFF8F7F4);
  static const Color premiumNavy = Color(0xFF0B1C2D);
  static const Color premiumBlue = Color(0xFF2F5BFF);
  static const Color premiumBlack = Color(0xFF111111);
  
  // Legacy/Semantic mapping for transition
  static const Color primaryBlue = premiumBlue;
  static const Color secondaryBlue = Color(0xFFEBEFFF);
  static const Color accentEmerald = Color(0xFF10B981);
  static const Color background = premiumBackground;
  static const Color surface = Colors.white;
  static const Color card = Colors.white;
  static const Color textBody = premiumBlack;
  static const Color textHeadline = premiumNavy;
  
  // Build compatibility aliases
  static const Color white = Colors.white; // Backgrounds
  static const Color darkBackground = Color(0xFF0F1216);
  static const Color lightBackground = Color(0xFFF4F6F8);
  static const Color surfaceDark = Color(0xFF1E2126);
  
  // Profile specific colors
  static const Color profileCardDark = Color(0xFF1A1F26);
  static const Color profileCardLight = Colors.white;
  static const Color profileTextDark = Color(0xFFE6E9EE);
  static const Color profileSubtextDark = Color(0xFF9AA4AF);
  static const Color profileDividerDark = Color(0xFF2A2F36);
  
  static const Color profileTextLight = Color(0xFF1C1E21);
  static const Color profileSubtextLight = Color(0xFF5F6B7A);
  static const Color profileDividerLight = Color(0xFFE0E3E7);
  
  static const Color profileAccent = Color(0xFF1F6BFF);
  
  // Gradients
  static const LinearGradient profileBgGradientDark = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [darkBackground, profileCardDark],
  );
  
  static const LinearGradient profileBgGradientLight = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFFE9EDF2), Color(0xFFF7F9FB)],
  );
  
  // Text
  static const Color textDark = Color(0xFF000000); 
  static const double textHeadingOpacity = 0.90;
  static const double textSecondaryOpacity = 0.70;
  static const double textMutedOpacity = 0.40;

  static const Color textMedium = Color(0xFF4A4A4A);
  static const Color textLight = Color(0xFF7A7A7A);
  
  static const Color textDarkTheme = Color(0xFFE0E0E0);
  static const Color textMediumTheme = Color(0xFFA0A0A0);

  // Status
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);

  // Border
  static const Color border = premiumBlack;
  static const Color borderDark = Color(0xFF2C2C2C);
  
  // Neo-Brutalism specific
  static const Color neoDarkBorder = premiumBlack;
  static const Color neoShadow = Color(0xCC111111); // Professional 80% opacity black
  
  // Design Refinement Tints
  static const Color blueTint = Color(0xFFEBEFFF);
  static const Color orangeTint = Color(0xFFFFF7ED);
  static const Color surfaceMuted = Color(0xFFF0F0F0);
}
