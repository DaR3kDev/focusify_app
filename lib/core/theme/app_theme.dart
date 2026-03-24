import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFFFF8A3D);

  // =========================
  // DARK THEME
  // =========================
  static final ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF0D0F14),

    colorScheme: const ColorScheme.dark(
      primary: primaryColor,
      secondary: primaryColor,
      surface: Color(0xFF161A22),
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF0D0F14),
      elevation: 0,
    ),

    cardColor: const Color(0xFF161A22),

    sliderTheme: const SliderThemeData(
      activeTrackColor: primaryColor,
      thumbColor: primaryColor,
      inactiveTrackColor: Colors.white12,
    ),

    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.all(primaryColor),
      trackColor: WidgetStateProperty.all(primaryColor.withValues(alpha: 0.4)),
    ),

    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: Colors.white70),
      bodySmall: TextStyle(color: Colors.white54),
      titleLarge: TextStyle(color: Colors.white),
    ),
  );

  // =========================
  // LIGHT THEME
  // =========================
  static final ThemeData light = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: const Color(0xFFF5F5F5),

    colorScheme: const ColorScheme.light(
      primary: primaryColor,
      secondary: primaryColor,
      surface: Colors.white,
    ),

    appBarTheme: const AppBarTheme(backgroundColor: Colors.white, elevation: 0),

    cardColor: Colors.white,

    sliderTheme: const SliderThemeData(
      activeTrackColor: primaryColor,
      thumbColor: primaryColor,
      inactiveTrackColor: Colors.black12,
    ),

    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.all(primaryColor),
      trackColor: WidgetStateProperty.all(primaryColor.withValues(alpha: 0.3)),
    ),

    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: Colors.black87),
      bodySmall: TextStyle(color: Colors.black54),
      titleLarge: TextStyle(color: Colors.black),
    ),
  );
}
