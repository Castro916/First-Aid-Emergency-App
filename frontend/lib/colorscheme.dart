import 'package:flutter/material.dart';

class AppColors {
  // Light Theme Colors
  static const Color lightBackground = Color(0xFFF5F5F5);
  static const Color lightText = Color(0xFF333333);
  static const Color lightSurface = Colors.white;

  // Dark Theme Colors
  static const Color darkBackground = Color(0xFF121212);
  static const Color darkText = Colors.white;
  static const Color darkSurface = Color(0xFF1E1E1E);

  static ColorScheme get lightScheme => const ColorScheme.light(
    primary: Colors.red,
    surface: lightSurface,
    onSurface: lightText,
    // Using surfaceContainerLow as a proxy for our background color in M3
    surfaceContainerLow: lightBackground, 
  );

  static ColorScheme get darkScheme => const ColorScheme.dark(
    primary: Colors.red,
    surface: darkSurface,
    onSurface: darkText,
    surfaceContainerLow: darkBackground,
  );
}
