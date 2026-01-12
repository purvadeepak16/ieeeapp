import 'package:flutter/material.dart';

extension ContextExtensions on BuildContext {
  // Theme Helpers
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme;
  ColorScheme get colorScheme => theme.colorScheme;
  bool get isDarkMode => theme.brightness == Brightness.dark;

  // Media Query Helpers
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  double get screenWidth => mediaQuery.size.width;
  double get screenHeight => mediaQuery.size.height;
  EdgeInsets get padding => mediaQuery.padding;
  EdgeInsets get viewInsets => mediaQuery.viewInsets;

  // Spacing Helpers
  SizedBox gap(double size) => SizedBox(height: size, width: size);
  SizedBox get gapXs => const SizedBox(height: 4, width: 4);
  SizedBox get gapSm => const SizedBox(height: 8, width: 8);
  SizedBox get gapMd => const SizedBox(height: 16, width: 16);
  SizedBox get gapLg => const SizedBox(height: 24, width: 24);
  SizedBox get gapXl => const SizedBox(height: 32, width: 32);
}
