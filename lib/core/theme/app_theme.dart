import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  // Palette
  static const Color background = Color(0xFF0D0D0D);
  static const Color surface = Color(0xFF1A1A1A);
  static const Color accent = Color(0xFFE8D5B7);       // warm off-white
  static const Color accentDim = Color(0xFF6B5F4E);
  static const Color textPrimary = Color(0xFFEFEFEF);
  static const Color textSecondary = Color(0xFF7A7A7A);
  static const Color progressTrack = Color(0xFF2A2A2A);
  static const Color success = Color(0xFF5CC47E);
  static const Color error = Color(0xFFE06060);

  static ThemeData get dark => ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: background,
        colorScheme: const ColorScheme.dark(
          surface: surface,
          primary: accent,
          secondary: accentDim,
          error: error,
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            color: textPrimary,
            fontSize: 72,
            fontWeight: FontWeight.w200,
            letterSpacing: -2,
          ),
          titleLarge: TextStyle(
            color: textPrimary,
            fontSize: 22,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.5,
          ),
          bodyMedium: TextStyle(
            color: textSecondary,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          labelSmall: TextStyle(
            color: accentDim,
            fontSize: 11,
            letterSpacing: 2,
            fontWeight: FontWeight.w500,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: surface,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          hintStyle: const TextStyle(color: textSecondary),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        ),
        useMaterial3: true,
      );
}
