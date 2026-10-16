import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryColor = Colors.indigoAccent;
  static const Color hintColor = Colors.grey;
  static const Color labelColor = Colors.grey;
}

class AppTheme {

  static final ThemeData light = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primaryColor,
      brightness: Brightness.light,
    ).copyWith(
      primary: AppColors.primaryColor,
      surface: const Color(0xFFF4F4F5),
      surfaceContainer: Colors.white,
    ),
  );

  static final ThemeData dark = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primaryColor,
      brightness: Brightness.dark,
    ).copyWith(
      primary: AppColors.primaryColor,
      surface: const Color(0xFF121318),
      surfaceContainer: const Color(0xFF25262D),
    ),
  );
}
