import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static const Color primaryColor = Colors.indigoAccent;
  static const Color hintColor = Colors.grey;
  static const Color labelColor = Colors.grey;
  static const Color borderColor = Colors.grey;

  static const Color backgroundLight = Color(0xFFF4F4F5);
  static const Color containerLight = Colors.white;
  static const Color backgroundDark = Color(0xFF121318);
  static const Color containerDark = Color(0xFF25262D);

  static final lightColorScheme =
      ColorScheme.fromSeed(
        seedColor: primaryColor,
        brightness: Brightness.light,
      ).copyWith(
        primary: primaryColor,
        surface: backgroundLight,
        surfaceContainer: containerLight,
        outlineVariant: const Color(0xFFE4E4E7),
      );

  static final darkColorScheme =
      ColorScheme.fromSeed(
        seedColor: primaryColor,
        brightness: Brightness.dark,
      ).copyWith(
        primary: primaryColor,
        surface: backgroundDark,
        surfaceContainer: containerDark,
        outlineVariant: const Color(0xFF3F3F46),
      );

  static final ThemeData light = ThemeData(
    colorScheme: lightColorScheme,
    cardTheme: CardThemeData(
      color: lightColorScheme.surfaceContainer,
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: lightColorScheme.outlineVariant),
      ),
    ),
  );

  static final ThemeData dark = ThemeData(
    colorScheme: darkColorScheme,
    cardTheme: CardThemeData(
      color: darkColorScheme.surfaceContainer,
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: darkColorScheme.outlineVariant),
      ),
    ),
  );
}
